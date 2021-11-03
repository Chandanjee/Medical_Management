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
        let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothTab())
        let navigation = UINavigationController.init(rootViewController: dashboard)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func smoothTab() -> [TabItem] {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"DashboardViewController") as? DashboardViewController
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        v2?.tabController = .Profile
      let v3 = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        v3?.tabController = .Setting
      //let v4 = ViewController()
      //v4.tabController = .Profile
      
      
        let t1 = TabItem(v1!, imageName: "home_blue", tabName: "Home")
        let t2 = TabItem(v2!, imageName: "profile", tabName: "Profile")
      let t3 = TabItem(v3!, imageName: "settingIcon", tabName: "Setting")
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
}

