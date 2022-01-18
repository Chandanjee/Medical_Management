//
//  UserMenualVC.swift
//  Decoy
//
//  Created by Maa on 17/01/22.
//

import UIKit
import PDFKit
import MBProgressHUD
import WebKit
import MBProgressHUD

class UserMenualVC: UIViewController {

    
    var pdfURL: URL!
private let document: PDFDocument! = nil
private let outline: PDFOutline? = nil
private var pdfView = PDFView()
var titleData = ""
    var DataName = ""

@IBOutlet weak var titleLabel:UILabel!
@IBOutlet weak var pdfFile:UIView!
@IBOutlet weak var btnBack:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let images = UIImage(named: "back")
        btnBack.setImage(images?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        btnBack.tintColor = UIColor.white
        MBProgressHUD.showAdded(to: self.view, animated: true)
        titleLabel.text = "User Manual"

//        if let document = PDFDocument(url: pdfURL) {
//                  pdfView.document = document
//            MBProgressHUD.hide(for: self.view, animated: true)
//
//              }
//        self.pdfFile.addSubview(pdfView)
        // Do any additional setup after loading the view.
        var url :URL? = nil
        if DataName == "Patient" {

             url = Bundle.main.url(forResource: "UserManual_PatientMobileApp", withExtension: "pdf")
        }else{
             url = Bundle.main.url(forResource: "UserManual_OfficialMobileApp", withExtension: "pdf")
        }
          if let url = url {
              let webView = WKWebView(frame: view.frame)
              let urlRequest = URLRequest(url: url)
              webView.load(urlRequest)
              pdfFile.addSubview(webView)
              MBProgressHUD.hide(for: self.view, animated: true)

          }
    }
    
    private func addPDFView() {
           let pdfView = PDFView()
           pdfView.translatesAutoresizingMaskIntoConstraints = false
        pdfFile.addSubview(pdfView)
       
           pdfView.leadingAnchor.constraint(equalTo: pdfFile.safeAreaLayoutGuide.leadingAnchor).isActive = true
           pdfView.trailingAnchor.constraint(equalTo: pdfFile.safeAreaLayoutGuide.trailingAnchor).isActive = true
           pdfView.topAnchor.constraint(equalTo: pdfFile.safeAreaLayoutGuide.topAnchor).isActive = true
           pdfView.bottomAnchor.constraint(equalTo: pdfFile.safeAreaLayoutGuide.bottomAnchor).isActive = true
           
           pdfView.autoScales = true
           pdfView.displayMode = .singlePageContinuous
           pdfView.displayDirection = .vertical
           
           ///Open pdf with help of FileManager URL
           if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
               let bookWithPdf = "xyz.pdf"
               let fileURL = dir.appendingPathComponent(bookWithPdf)
               let document = PDFDocument(url: fileURL)
               pdfView.document = document
           }
    }
    
    @IBAction func tapTOback(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
}
