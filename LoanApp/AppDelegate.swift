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
        
        AppsFlyerLib.shared().appsFlyerDevKey = "JdRpjKW5ZGx2GH6cekoTtb"
        AppsFlyerLib.shared().appleAppID = "6473890001"
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().isDebug = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
                name: UIApplication.didBecomeActiveNotification,
                object: nil)
    }
    
    // MARK: SceneDelegate support - start AppsFlyer SDK
    
    @objc func didBecomeActiveNotification() {
        if #available(iOS 14, *) {
            AppsFlyerLib.shared().start()
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
    
    // MARK: UISceneSession Lifecycle
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}
