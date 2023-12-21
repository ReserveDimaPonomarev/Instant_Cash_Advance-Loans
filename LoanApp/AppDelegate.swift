//
//  AppDelegate.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit
import OneSignalFramework
import AppsFlyerLib
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var ConversionData: [AnyHashable: Any]? = nil

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
                     [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppsFlyerLib()
        setupOneSignal(launchOptions: launchOptions)
        return true
    }
    
    // MARK: setupOneSignal
    
    func setupOneSignal(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Remove this method to stop OneSignal Debugging
        OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        // OneSignal initialization
        OneSignal.initialize("b029c735-2bbc-4682-8902-2078177136ed", withLaunchOptions: launchOptions)
        
        // requestPermission will show the native iOS notification permission prompt.
        // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
        OneSignal.Notifications.requestPermission({ accepted in
            print("User accepted notifications: \(accepted)")
        }, fallbackToSettings: true)
        // Login your customer with externalId
        // OneSignal.login("EXTERNAL_ID")
        
    }
    
    // MARK: setupAppsFlyerLib
    
    func setupAppsFlyerLib() {
        // MARK: keys for AppsFlyerLib
        
        AppsFlyerLib.shared().isDebug = true
        
        // Replace 'appsFlyerDevKey', `appleAppID` with your DevKey, Apple App ID
        AppsFlyerLib.shared().appsFlyerDevKey = "JdRpjKW5ZGx2GH6cekoTtb"
        AppsFlyerLib.shared().appleAppID = "6473890001"
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
               
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().deepLinkDelegate = self
        AppsFlyerLib.shared().appendParametersToDeeplinkURL(contains: "testloanas.onelink.me", parameters: ["pid" : "exampleDomain"])

        //set the OneLink template id for share invite links
        AppsFlyerLib.shared().appInviteOneLinkID = "vwU8"
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
                name: UIApplication.didBecomeActiveNotification,
                object: nil)
                
    }
    
    // MARK: SceneDelegate support - start AppsFlyer SDK
    
    @objc func didBecomeActiveNotification() {
        AppsFlyerLib.shared().start()
        if #available(iOS 14, *) {
          ATTrackingManager.requestTrackingAuthorization { (status) in
            switch status {
            case .denied:
                print("AuthorizationSatus is denied")
            case .notDetermined:
                print("AuthorizationSatus is notDetermined")
            case .restricted:
                print("AuthorizationSatus is restricted")
            case .authorized:
                print("AuthorizationSatus is authorized")
            @unknown default:
                fatalError("Invalid authorization status")
            }
          }
        }
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }
            
    // Open URI-scheme for iOS 9 and above
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
    
    // Report Push Notification attribution data for re-engagements
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    
    // MARK: UISceneSession Lifecycle
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}


extension AppDelegate: DeepLinkDelegate {
     
    func didResolveDeepLink(_ result: DeepLinkResult) {
        var fruitNameStr: String?
        switch result.status {
        case .notFound:
            NSLog("[AFSDK] Deep link not found")
            return
        case .failure:
            print("Error %@", result.error!)
            return
        case .found:
            NSLog("[AFSDK] Deep link found")
        }
        
        guard let deepLinkObj:DeepLink = result.deepLink else {
            NSLog("[AFSDK] Could not extract deep link object")
            return
        }
        
        if deepLinkObj.clickEvent.keys.contains("campaign") {
            let ReferrerId:String = deepLinkObj.clickEvent["campaign"] as! String
            NSLog("[AFSDK] AppsFlyer: Referrer ID: \(ReferrerId)")
            print(ReferrerId)
        } else {
            NSLog("[AFSDK] Could not extract referrerId")
        }
        fruitNameStr = deepLinkObj.deeplinkValue
        ConversionData = result.deepLink?.clickEvent
        //If deep_link_value doesn't exist
        if fruitNameStr == nil || fruitNameStr == "" {
            //check if fruit_name exists
            switch deepLinkObj.clickEvent["fruit_name"] {
                case let s as String:
                    fruitNameStr = s
                default:
                    print("[AFSDK] Could not extract deep_link_value or fruit_name from deep link object with unified deep linking")
                    return
            }
        }
    }
}


extension AppDelegate: AppsFlyerLibDelegate {
     
    // Handle Organic/Non-organic installation
    func onConversionDataSuccess(_ data: [AnyHashable: Any]) {
        ConversionData = data
        print("onConversionDataSuccess data:")
        for (key, value) in data {
            print(key, ":", value)
        }
        if let conversionData = data as NSDictionary? as! [String:Any]? {
        
            if let status = conversionData["af_status"] as? String {
                if (status == "Non-organic") {
                    if let sourceID = conversionData["media_source"],
                        let campaign = conversionData["campaign"] {
                        NSLog("[AFSDK] This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                    }
                } else {
                    NSLog("[AFSDK] This is an organic install.")
                }
                
                if let is_first_launch = conversionData["is_first_launch"] as? Bool,
                    is_first_launch {
                    NSLog("[AFSDK] First Launch")
                    if !conversionData.keys.contains("deep_link_value") && conversionData.keys.contains("fruit_name"){
                        switch conversionData["fruit_name"] {
                            case let fruitNameStr as String:
                            NSLog("This is a deferred deep link opened using conversion data")
                            default:
                                NSLog("Could not extract deep_link_value or fruit_name from deep link object using conversion data")
                                return
                        }
                    }
                } else {
                    NSLog("[AFSDK] Not First Launch")
                }
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        NSLog("[AFSDK] \(error)")
    }
}
