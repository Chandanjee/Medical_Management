//
//  OfficialDashboardVC.swift
//  Decoy
//
//  Created by MAC on 12/12/21.
//

import UIKit
import WebKit

class OfficialDashboardVC: UIViewController {
    var tabController: VC_TYPE = .Home
    @IBOutlet weak var backSideDash:UIView!

    @IBOutlet weak var webViewDash:WKWebView!
    var webViewss: WKWebView!

    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    let serviceUrl = WebServiceTesing + "dashboard/dashboard"
    
    /*
    override func loadView() {
       let webConfiguration = WKWebViewConfiguration()
        webViewss = WKWebView(frame: .zero, configuration: webConfiguration)
        webViewss.uiDelegate = self
//        self.backSideDash = webView
        self.backSideDash.addSubview(webViewss)
            self.backSideDash.sendSubviewToBack(webViewss)

    }*/
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let myURL = URL(string:serviceUrl)
//             let myRequest = URLRequest(url: myURL!)
//        let webConfiguration = WKWebViewConfiguration()
//        let webViews = WKWebView(frame: .zero, configuration: webConfiguration)
//        webViews.uiDelegate = self
//        webView.load(myRequest)
        let myRequest = URLRequest(url: myURL!)
                webView.load(myRequest)
        self.webView.navigationDelegate = self
         self.backSideDash.addSubview(webView)
//             self.backSideDash.sendSubviewToBack(webView)
        // Do any additional setup after loading the view.
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

extension OfficialDashboardVC:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
          print("Started to load")
      }

      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
          print("Finished loading")
      }

      func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
          print(error.localizedDescription)
      }
}
