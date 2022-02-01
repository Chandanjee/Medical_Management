//
//  PrivacyPolicyVC.swift
//  Decoy
//
//  Created by Maa on 02/02/22.
//

import UIKit
import WebKit

class PrivacyPolicyVC: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var btnBackSide:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        if let filePath = Bundle.main.url(forResource: "privacypolicy", withExtension: "html") {
//          let request = NSURLRequest(url: filePath)
//          webView.load(request as URLRequest)
//        }
        
        let indexPath = Bundle.main.path(forResource: "privacypolicy", ofType: "html", inDirectory: "/")
               if let indexPath = indexPath
               {
                   do
                   {
                       let htmlContent = try String(contentsOfFile: indexPath, encoding: String.Encoding.utf8)

                       let base = Bundle.main.resourceURL
                       self.webView.loadHTMLString(htmlContent, baseURL: base)

                   }
                   catch let err as NSError
                   {
                       print(err.debugDescription)
                   }
               }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func tapToBack(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
}
