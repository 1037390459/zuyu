//
//  SceneDelegate.swift
//  ZuYu
//
//  Created by million on 2020/7/11.
//  Copyright © 2020 million. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateInitialViewController()
        window?.makeKeyAndVisible()
        AppDelegate.shared.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
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
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        print(url)
        if url.host == "safepay"{//支付宝
            //支付回调
            AlipaySDK.defaultService().processOrder(withPaymentResult: url, standbyCallback:{ (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showResult(result:resultDic! as NSDictionary)
                }
            })
            //授权回调
            AlipaySDK.defaultService().processAuth_V2Result(url, standbyCallback: { (resultDic) in
                if resultDic != nil{
                    AliPayManager.shared.showAuth_V2Result(result:resultDic! as NSDictionary)
                }
            })
        } else {//微信
             WXApi.handleOpen(url,delegate:WXApiManager.shared)
        }
    }
    
}
