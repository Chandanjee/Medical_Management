//
//  AppDelegate.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        window = UIWindow(frame: UIScreen.main.bounds)
        if let userData = UserDefaults.standard.value(forKey: "userLoginStatus") as? String {
            if userData == "Yes" {
                showDashboard()

            }else{
                defaultLoginScreen()
            }
        }else{
            defaultLoginScreen()
        }
//            let mainstoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let newViewcontroller:UIViewController = mainstoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            navigationController = UINavigationController(rootViewController: newViewcontroller)
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func showDashboard() {
        var _: UIWindow?
//        userLoginType
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
            return
            
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

        window.rootViewController = vc

        // add animation
        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromLeft],
                          animations: nil,
                          completion: nil)

    }
    
    func smoothOfficialTab() -> [TabItem] {
        
//        Dummy = 5
//       case Home = 0
//       case Profile = 1
//       case Setting = 2
//       case Menu = 3
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
        window = UIWindow(frame: UIScreen.main.bounds)
        
               let home = TabbarViewController()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier:"TabbarViewController") as? TabbarViewController
        let navController = UINavigationController(rootViewController: v1!)
        self.window!.rootViewController = navController
//               self.window?.rootViewController = home
        self.window!.makeKeyAndVisible()
//               window?.windowScene = windowScene
    }
}

