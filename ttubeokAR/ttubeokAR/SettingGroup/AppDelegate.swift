//
//  AppDelegate.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/2/24.
//

import UIKit
import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return false
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        KakaoSDK.initSDK(appKey: "1c831262e8deaf4f7823434057f15384")
        
        // Create the SwiftUI view that provides the window contents.
        //MainViewControl().environmentObject(SharedTabInfo())
        //WalkwayPageContent(viewModel: WalkwayViewModel())
        let contentView = LoginViewCycle()
        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: contentView)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    /// 루트뷰 변환 애니메이션 적용
    /// - Parameters:
    ///   - viewController: 변경하고자 하는 뷰 컨트롤러 작성
    ///   - animated: 변경될 때 발생하는 루트 뷰
    func changeRootViewController(_ viewController: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        
        if animated {
            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromRight, animations: {
                window.rootViewController = viewController
            })
        } else {
            window.rootViewController = viewController
        }
    }
    
    /// 스플래시 뷰 -> 로그인 뷰 전환 애내메이션
    /// - Parameters:
    ///   - ViewController: 변환하고자 하는 로그인 뷰 전환 뷰
    ///   - animated: 변환 애니메이션
    func changeRootSplashView(_ ViewController: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        
        if animated {
            UIView.transition(with: window, duration: 1.0, options: .transitionCrossDissolve, animations: {
                window.rootViewController = ViewController
                window.makeKeyAndVisible()
            }, completion: nil)
        } else {
            window.rootViewController = ViewController
        }
    }


}

