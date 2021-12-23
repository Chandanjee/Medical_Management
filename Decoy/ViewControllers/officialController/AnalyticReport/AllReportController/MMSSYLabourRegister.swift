//
//  MMSSYLabourRegister.swift
//  Decoy
//
//  Created by MAC on 22/12/21.
//

import UIKit
import WebKit
import MBProgressHUD

class MMSSYLabourRegister: UIViewController {
    
    @IBOutlet weak var backSideZone:UIView!
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()

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

extension MMSSYLabourRegister:WKUIDelegate,WKNavigationDelegate{
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
