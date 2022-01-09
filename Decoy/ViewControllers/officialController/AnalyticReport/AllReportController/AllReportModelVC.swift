//
//  AllReportModelVC.swift
//  Decoy
//
//  Created by Maa on 24/12/21.
//

import UIKit
import WebKit
import MBProgressHUD

class AllReportModelVC: UIViewController {
    
    @IBOutlet weak var backSideSubM:UIView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var backButton:UIButton!
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.backSideSubM.frame.width, height: self.backSideSubM.frame.height), configuration: webConfiguration)
        webView.uiDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    var serviceURL =   ""
    var titlename = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
        SelectURL()
        let myURL = URL(string:serviceURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.webView.navigationDelegate = self
        self.backSideSubM.addSubview(webView)
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
    
    @IBAction func tapToBackModul(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    /*
     1."registration/showOPDRegister"
      MMU Register
     
     2."opd/opdPrescriptionReports"
      OPD Reports

     3."registration/campMonthlyPlanReport"
      "Monthly Camp Plan Report

     4."mis/dailyMmuRegister"
      Daily MMU Register

     5."mis/showIndentRegister"
      Indent Register

     6."mis/showMedicineIssueRegister"
      Medicine Issue Register

     
     7."store/showStockStatusReport"
     Stock Status Report
     
     "store/showOpeningBalanceRegister"
      "Opening Balance Register"

     "dispencery/drugExpiryList"
      Drug Expiry Report

     "mis/mmssyInformationRegister"
      MMSSY Information Register

     "mis/labourBeneficiaryRegister"
      MMSSY Labour beneficiary register

     "mis/daiDidiDailyRegister"
      Dai Didi Daily clinic register

     "mis/incidentRegister"
      Incident Register

     "mis/attendanceRegister"
     Attendance Register
     
     "store/showStockTakingRegister"
     Stock taking register
     
     "mis/penaltyRegister"
     Penalty Register

     
     "mis/equipmentChecklistRegister"
      Equipment Checklist Register

     */
    
    func SelectURL()  {
        if titlename == "MMU Register"{
            self.titleLbl.text = "MMU Register"
            serviceURL = WebService + "registration/showOPDRegister"
            
        }else   if titlename == "OPD Reports"{
            self.titleLbl.text = "OPD Reports"
            serviceURL = WebService + "opd/opdPrescriptionReports"
            
        }else   if titlename == "Monthly Camp Reports"{
            self.titleLbl.text = "Monthly Camp Reports"
            serviceURL = WebService + "registration/campMonthlyPlanReport"
            
        }else   if titlename == "Daily MMU Register"{
            self.titleLbl.text = "Daily MMU Register"
            serviceURL = WebService + "mis/dailyMmuRegister"
            
        }else   if titlename == "Indent Register"{
            self.titleLbl.text = "Indent Register"
            serviceURL = WebService + "mis/showIndentRegister"
            
        }else   if titlename == "Medicine Issue Register"{
            self.titleLbl.text = "Medicine Issue Register"
            serviceURL = WebService + "mis/showMedicineIssueRegister"
            
        }else   if titlename == "Stock Status Reports"{
            self.titleLbl.text = "Stock Status Reports"
            serviceURL = WebService + "store/showStockStatusReport"
            
        }else   if titlename == "Opening Balance Register"{
            self.titleLbl.text = "Opening Balance Register"
            serviceURL = WebService + "store/showOpeningBalanceRegister"
            
        }else   if titlename == "Drug Expiry Reports"{
            self.titleLbl.text = "Drug Expiry Reports"
            serviceURL = WebService + "dispencery/drugExpiryList"
            
        }else   if titlename == "MMSSY Information Register"{
            self.titleLbl.text = "MMSSY Information"
            serviceURL = WebService + "mis/mmssyInformationRegister"
            
        }else   if titlename == "MMSSY Labour Beneficiary Register"{
            self.titleLbl.text = "MMSSY Labour Beneficiary"
            serviceURL = WebService + "mis/labourBeneficiaryRegister"
            
        }else   if titlename == "Dai Didi Clinic Register"{
            self.titleLbl.text = "Dai Didi Clinic"
            serviceURL = WebService + "mis/daiDidiDailyRegister"
            
        }else   if titlename == "Incident Register"{
            self.titleLbl.text = "Incident Register"
            serviceURL = WebService + "mis/incidentRegister"
            
        }else   if titlename == "Attendance Register"{
            self.titleLbl.text = "Attendance Register"
            serviceURL = WebService + "mis/attendanceRegister"
            
        }else   if titlename == "Stock Taking Register"{
            self.titleLbl.text = "Stock Taking Register"
            serviceURL = WebService + "store/showStockTakingRegister"
            
        }else   if titlename == "Penalty Register"{
            self.titleLbl.text = "Penalty Register"
            serviceURL = WebService + "mis/penaltyRegister"
            
        }else   if titlename == "Equipment Checklist Register"{
            self.titleLbl.text = "Equipment Checklist Register"
            serviceURL = WebService + "mis/equipmentChecklistRegister"
        }
    }
}

extension AllReportModelVC:WKUIDelegate,WKNavigationDelegate{
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
