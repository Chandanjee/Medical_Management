//
//  Loader.swift
//  SMAC
//
//  Created by Chandan Jee on 22/10/21.
//

import Foundation
import MBProgressHUD
import UIKit
import SystemConfiguration
//import MaterialComponents.MaterialSnackbar
import CoreLocation
import CoreTelephony


class Loader {
    
    // MARK: - Loading Indicator
    static let thickness = CGFloat(6.0)
    static let radius = CGFloat(22.0)
    static let indicatorTintColor = UIColor.clear

    class func showLoader(_ title: String = "Loading...", target: UIViewController? = nil) {
        if let target = target {
                showLoaderInView(title, view: target.view)
        }
    }
    
    class func showLoaderInView(_ title: String , view: UIView) {
        if Utility.isInternetAvailable() == false { return }
        DispatchQueue.main.async {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = MBProgressHUDMode.indeterminate
            hud.contentColor = UIColor.themeColor()
            hud.bezelView.color = UIColor.clear
            hud.backgroundView.color = UIColor.clear
            hud.label.text = title
        }
    }
    
    class func hideLoader(_ target: UIViewController?) {
        if let target = target {
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: target.view, animated: true)
            }
        }
    }
    
    class func hideLoaderInView(view: UIView) {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
 
    
}
