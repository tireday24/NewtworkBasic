//
//  SceneDelegate.swift
//  SeSAC2LectureNewtworkBasic
//
//  Created by 권민서 on 2022/07/27.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        //Bedge 제거
        // active 상태에서 벳지 사라짐 언제 쓰는지를 알자
        //appdelegate에서 didfinish에서 쓰면 terminate 되어지지 않는 이상 벳지는 없어지지 않는다
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //becomeActive가 포그라운드 보다 나은 이유(차이점) -> 알림 와서 잠깐 나갔다 들어온 상태는 포그라운드 그래서 시점이 명확한 시점이 didbecomeactive
        // Called as the scene transitions from the background to the foreground.
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // 앱을 켜질 때 앱이 실행됐을 때의 의미 앱이 켜져있는 상태에서 전화가 오고 받은 후에 다시 키면 포그라운드 함수 호출x inactive상태에서 다시 돌아오면 포그라운드 매서드 호출x
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

