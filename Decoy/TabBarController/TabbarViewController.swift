//
//  TabbarViewController.swift
//  Decoy
//
//  Created by MAC on 19/12/21.
//

import UIKit

class TabbarViewController: UITabBarController {
    
    let coustmeTabBarView:UIView = {
           
           //  daclare coustmeTabBarView as view
           let view = UIView(frame: .zero)
           
           // to make the cornerRadius of coustmeTabBarView
           view.backgroundColor = .white
           view.layer.cornerRadius = 20
           view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
           view.clipsToBounds = true
           
           // to make the shadow of coustmeTabBarView
           view.layer.masksToBounds = false
           view.layer.shadowColor = UIColor.black.cgColor
           view.layer.shadowOffset = CGSize(width: 0, height: -8.0)
           view.layer.shadowOpacity = 0.12
           view.layer.shadowRadius = 10.0
           return view
       }()
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
            UITabBar.appearance().barTintColor = .systemBackground
            tabBar.tintColor = .label


        } else {
            // Fallback on earlier versions
        }
        addcoustmeTabBarView()
        hideTabBarBorder()
        setupVCs()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
          coustmeTabBarView.frame = tabBar.frame
       }
    
    override func viewDidAppear(_ animated: Bool) {
        var newSafeArea = UIEdgeInsets()

        // Adjust the safe area to the height of the bottom views.
        newSafeArea.bottom += coustmeTabBarView.bounds.size.height

        // Adjust the safe area insets of the
        //  embedded child view controller.
        self.children.forEach({$0.additionalSafeAreaInsets = newSafeArea})
    }
    
    
    private func addcoustmeTabBarView() {
        //
       coustmeTabBarView.frame = tabBar.frame
        view.addSubview(coustmeTabBarView)
        view.bringSubviewToFront(self.tabBar)
    }
    
    
    func hideTabBarBorder()  {
        let tabBar = self.tabBar
        tabBar.backgroundImage = UIImage.from(color: .clear)
        tabBar.shadowImage = UIImage()
        tabBar.clipsToBounds = true

    }
    
    func setupVCs() {
//          viewControllers = [
//              createNavController(for: ViewController(), title: NSLocalizedString("Search", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
//              createNavController(for: ViewController(), title: NSLocalizedString("Home", comment: ""), image: UIImage(systemName: "house")!),
//              createNavController(for: ViewController(), title: NSLocalizedString("Profile", comment: ""), image: UIImage(systemName: "person")!)
//          ]
      }
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                                     title: String,
                                                     image: UIImage) -> UIViewController {
           let navController = UINavigationController(rootViewController: rootViewController)
           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           navController.navigationBar.prefersLargeTitles = true
           rootViewController.navigationItem.title = title
           return navController
       }

}

extension UIImage {
    static func from(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}
