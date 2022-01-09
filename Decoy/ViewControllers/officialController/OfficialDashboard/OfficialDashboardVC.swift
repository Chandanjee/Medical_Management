//
//  OfficialDashboardVC.swift
//  Decoy
//
//  Created by MAC on 12/12/21.
//

import UIKit
import WebKit
import JavaScriptCore
import MBProgressHUD

class OfficialDashboardVC: UIViewController {
    var tabController: VC_TYPE = .Home
    @IBOutlet weak var backSideDash:UIView!
    @IBOutlet weak var webViewDash:WKWebView!
    
    let webViewTag = 2521
    let serviceUrl = WebService + "dashboard/dashboard"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let myURL = URL(string:serviceUrl)
        let myRequest = URLRequest(url: myURL!)
        webViewDash.load(myRequest)
        webViewDash.navigationDelegate = self
        webViewDash.tag = webViewTag
        webViewDash.uiDelegate = self
        webViewDash.translatesAutoresizingMaskIntoConstraints = false
        webViewDash.isHidden = true
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    func setupUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.view.backgroundColor = .white
    }
}

extension OfficialDashboardVC:WKUIDelegate,WKNavigationDelegate{
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
          print("Started to load")
        if let urlString = webView.url?.absoluteString {
            if urlString.contains("dashboard/mmuLogin") {
                if let tempWKWebView = self.view.viewWithTag(webViewTag) as? WKWebView {
                    tempWKWebView.isHidden = true
                }
            }
        }
      }

      func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
          print("Finished loading")
          
          //"userPassword"
          //"userMobile"
          print("webView Url - \(webView.url?.absoluteString)")
          
          if let urlString = webView.url?.absoluteString {
              if urlString.contains("dashboard/dashboard") {
                  if let tempWKWebView = self.view.viewWithTag(webViewTag) as? WKWebView {
                      DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                          MBProgressHUD.hide(for: (self.view)!, animated: true)
                          tempWKWebView.isHidden = false
                      }
                  }
              }
          }
          
          var savedUsername = ""
          var savedPassword = ""
          if let mNumber = UserDefaults.standard.value(forKey: "userMobile") as? String {
              savedUsername = mNumber
          }
          if let uPwd = UserDefaults.standard.value(forKey: "userPassword") as? String {
              savedPassword = uPwd
          }
          
          let userName = "javascript:document.getElementById('userId').value = " + "'" + "\(savedUsername)" + "'"
          let pwd = "javascript:document.getElementById('adPassword').value = " + "'" + "\(savedPassword)" + "'"
          let loginBtn = "javascript:document.getElementById('signIn').click();"

          webView.evaluateJavaScript(pwd) { val, error in
              if (error != nil) {
                  print("password Error: \(String(describing: error?.localizedDescription))")
              }
          }
          
          webView.evaluateJavaScript(userName) { val, error in
              if (error != nil) {
                  print("UserName Error: \(String(describing: error?.localizedDescription))")
              }
          }

          webView.evaluateJavaScript(loginBtn){ (value, error) in
              if error != nil {
                  print("login click Error: \(error?.localizedDescription)")
              }

          }
          
      }

      func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
          print("Dash login",error.localizedDescription)
      }
    
    
    func checkLoginFields() {
//      var usernameInput = document.getElementById("username");
//      var passwordInput = document.getElementById('password');
//      var signInButton = document.getElementById("login");
//      if (signInButton == null) {
//        return;
//      }
//      usernameInput.value = username;
//      passwordInput.value = password;
//      signInButton.click();
//      clearInterval(checkLogin);
    }
}
