//
//  PandemicZoneVC.swift
//  Decoy
//
//  Created by MAC on 12/12/21.
//

import UIKit
import WebKit
import MBProgressHUD

class PandemicZoneVC: UIViewController {
    var tabController: VC_TYPE = .Menu
    @IBOutlet weak var backSideZone:UIView!
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let  webViewf = WKWebView(frame: CGRect(x: 0, y: self.backSideZone.frame.height - 80, width: self.backSideZone.frame.width, height: self.backSideZone.frame.height))

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.backSideZone.frame.width, height: self.backSideZone.frame.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let serviceURL = WebServiceTesing + "master/zoneMaster"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let myURL = URL(string:serviceURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.webView.navigationDelegate = self

         self.backSideZone.addSubview(webView)
    }
    
    func setupUI() {
            self.view.backgroundColor = .white
            self.view.addSubview(webView)
            
            NSLayoutConstraint.activate([
                webView.topAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
                webView.leftAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                webView.bottomAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
                webView.rightAnchor
                    .constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor)
            ])
        }

  

}
extension PandemicZoneVC:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
          print("Started to load")
      }

      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
          print("Finished loading")
          MBProgressHUD.hide(for: (self.view)!, animated: true)

      }

      func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
          print(error.localizedDescription)
          MBProgressHUD.hide(for: (self.view)!, animated: true)

      }
}

