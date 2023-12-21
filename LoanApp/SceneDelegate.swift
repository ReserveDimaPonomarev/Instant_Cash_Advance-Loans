//
//  SceneDelegate.swift
//  LoanApp
//
//  Created by Дмитрий Пономарев on 29.11.2023.
//

import UIKit
import AppsFlyerLib

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        NSLog("[AFSDK] 1. %@", "scene with Universal Link")
        // Universal Link - Background -> foreground
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        // Background -> foreground
        NSLog("[AFSDK] 2. %@", "scene with URI scheme")
        if let url = URLContexts.first?.url {
            AppsFlyerLib.shared().handleOpen(url, options: nil)
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let userActivity = connectionOptions.userActivities.first {
            AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        } else if let url = connectionOptions.urlContexts.first?.url {
            AppsFlyerLib.shared().handleOpen(url, options: nil)
        }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = UINavigationController()
        let router = Router(navigationController: navigationController)
        appCoordinator = AppCoordinator(router: router)
        
        window = UIWindow(windowScene: windowScene)
        window?.overrideUserInterfaceStyle = .light
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        appCoordinator?.start()

    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

