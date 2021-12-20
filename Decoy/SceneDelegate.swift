//
//  SceneDelegate.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//

import UIKit
import IQKeyboardManagerSwift

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        IQKeyboardManager.shared.enable = true

        guard let _ = (scene as? UIWindowScene) else { return }
        if let userData = UserDefaults.standard.value(forKey: "userLoginStatus") as? String {
            if userData == "Yes" {
                showDashboard()

            }else{
                defaultLoginScreen()
            }
        }else{
            defaultLoginScreen()
        }
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
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

    func showDashboard() {
        var _: UIWindow?
        let segmentSelectedOption = UserDefaults.standard.value(forKey: "userLoginType") as? String
        if segmentSelectedOption == "Patient" {
            let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothTab())
            _ = UINavigationController.init(rootViewController: dashboard)
            if #available(iOS 13.0, *) {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(dashboard)
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(dashboard)
            }
        }else if segmentSelectedOption == "Official"{
            CustomeTabbar()
//            let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothOfficialTab())
//            _ = UINavigationController.init(rootViewController: dashboard)
//            if #available(iOS 13.0, *) {
//                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(dashboard)
//            } else {
//                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(dashboard)
//            }
        }
        
       
    }
    
    func smoothTab() -> [TabItem] {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"DashboardViewController") as? DashboardViewController
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "PatientProfileVC") as? PatientProfileVC
        v2?.tabController = .Setting
      let v3 = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        v3?.tabController = .Profile
      //let v4 = ViewController()
      //v4.tabController = .Profile
      
      
        let t1 = TabItem(v1!, imageName: "home_blue", tabName: "Home")
        let t2 = TabItem(v3!, imageName: "profile", tabName: "Profile")
      let t3 = TabItem(v2!, imageName: "settingIcon", tabName: "Setting")
      //let t4 = TabItem(v4, imageName: "profile", tabName: "Profile")
      
      return [t1,t2,t3]
    }

    
    func defaultLoginScreen(){
        let mainstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        let navigationController = UINavigationController(rootViewController: newViewcontroller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        let navigationController = UINavigationController(rootViewController: vc)

        window.rootViewController = navigationController

        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)

    }
    
    func smoothOfficialTab() -> [TabItem] {
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"OfficialDashboardVC") as? OfficialDashboardVC
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "AnalyticReportVC") as? AnalyticReportVC
        v2?.tabController = .Profile
        let v3 =  storyboard.instantiateViewController(withIdentifier: "PendingApprovalVC") as? PendingApprovalVC
          v3?.tabController = .Setting
        let v4 =  storyboard.instantiateViewController(withIdentifier: "PandemicZoneVC") as? PandemicZoneVC
          v4?.tabController = .Menu
      let v5 = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        v5?.tabControllerss = .Dummy
      
      
        let t1 = TabItem(v1!, imageName: "dashboard", tabName: "Home")
        let t2 = TabItem(v2!, imageName: "reportAnalysis", tabName: "Report")
        let t3 = TabItem(v3!, imageName: "medical_supply", tabName: "Approval")
        let t4 = TabItem(v4!, imageName: "pandemic", tabName: "Pandemic")
        let t5 = TabItem(v5!, imageName: "profile", tabName: "Profile")
      
      return [t1,t2,t3,t4,t5]
    }
    func CustomeTabbar(){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
               let home = TabbarViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier:"TabbarViewController") as? TabbarViewController
        let navController = UINavigationController(rootViewController: v1!)
        self.window!.rootViewController = navController
//               self.window?.rootViewController = home
        self.window!.makeKeyAndVisible()
               window?.windowScene = windowScene
    }
}

