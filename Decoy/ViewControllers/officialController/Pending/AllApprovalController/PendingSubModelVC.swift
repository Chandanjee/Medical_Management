//
//  PendingSubModelVC.swift
//  Decoy
//
//  Created by MAC on 23/12/21.
//

import UIKit
import WebKit
import MBProgressHUD

class PendingSubModelVC: UIViewController {
    
    @IBOutlet weak var backSideSub:UIView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var backButton:UIButton!

    var titlename = ""
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.backSideSub.frame.width, height: self.backSideSub.frame.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var serviceURL = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        if titlename == "Pending Indent For Approval (CO)"{
            self.titleLbl.text = "Approval (CO)"

            serviceURL = WebServiceTesing + "dispencery/getIndentApprovalListForCO"
       }else if titlename == "Pending Indent For Approval (APM)" {
           self.titleLbl.text = "Approval (APM)"
           serviceURL =   WebServiceTesing + "dispencery/getIndentForApproval"

        }else if titlename == "Pending Indent For Approval (Auditor)"{
            self.titleLbl.text = "Approval (Auditor)"
            serviceURL = WebServiceTesing + "dispencery/getIndentApprovalListForAuditor"

        }else if titlename == "Pending approval list of employee registration (APM)"{
            self.titleLbl.text = "Employee registration(APM)"

            serviceURL = WebServiceTesing + "empRegistration/getAPMWaitingList"

        }else if titlename == "Pending approval list of employee registration (Auditor)"{
            self.titleLbl.text = "Employee registration(Auditor)"

            serviceURL = WebServiceTesing + "empRegistration/getAuditorWaitingList"

        }else if titlename == "Pending approval list of employee registration (CHMO)"{
            self.titleLbl.text = "Employee registration(CHMO)"

            serviceURL = WebServiceTesing + "empRegistration/getCHMOWaitingList"

        }else if titlename == "Pending approval list of employee registration (UPSS)"{
            self.titleLbl.text = "Employee registration(UPSS)"

            serviceURL = WebServiceTesing + "empRegistration/getUPSSWaitingList"

        }
        let myURL = URL(string:serviceURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.webView.navigationDelegate = self
        self.backSideSub.addSubview(webView)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @IBAction func tapToBack(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
}

extension PendingSubModelVC:WKUIDelegate,WKNavigationDelegate{
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
