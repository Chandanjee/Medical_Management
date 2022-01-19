//
//  LatestUpdateVC.swift
//  Decoy
//
//  Created by Maa on 18/01/22.
//

import UIKit

class LatestUpdateVC: UIViewController {
    @IBOutlet weak var TopView : UIView!
    @IBOutlet weak var appIconImageView : UIImageView!
    @IBOutlet weak var tappIconImageView : UIImageView!
    @IBOutlet weak var tappTextImageView : UIImageView!
    @IBOutlet weak var btnAppUpdate : UIButton!
    @IBOutlet weak var lblAppName : UILabel!
    @IBOutlet weak var lblAppSlogan : UILabel!
    @IBOutlet weak var lblAppWhatsNew : UILabel!
    @IBOutlet weak var lblAppVersionHistory : UILabel!
    @IBOutlet weak var lblAppVersionDate : UILabel!
    @IBOutlet weak var lblAppBulid : UILabel!
    @IBOutlet weak var lblAppDetails : UILabel!
    @IBOutlet weak var lblProvider : UILabel!
    @IBOutlet weak var lblIcg1 : UILabel!
    @IBOutlet weak var lblLanguage : UILabel!
    @IBOutlet weak var lblEnglish : UILabel!
    @IBOutlet weak var lblCopyRight : UILabel!
    @IBOutlet weak var lblIcg2 : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UIApplication.shared.statusBarView?.backgroundColor = ColorCode.greenColor
        let version = versionAndBuildNumber()
        self.lblAppBulid.text = "MMSSY " + version
        btnAppUpdate.layer.cornerRadius = 10
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        let now = df.string(from: buildDate)
        self.lblAppVersionDate.text = now
        let radius: CGFloat = TopView.frame.width / 2.0 //change it to .height if you need spread for height
        let shadowPath = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 2.1 * radius, height: TopView.frame.height))
        
        TopView.layer.cornerRadius = 10; // if you like rounded corners
        TopView.layer.borderWidth = 5
        TopView.layer.borderColor = UIColor.gray.cgColor
        TopView.layer.masksToBounds = false;
        
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
       }
    
    @IBAction func btnbackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
     }
    
    func versionAndBuildNumber() -> String {
      let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
      let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
      if let versionNumber = versionNumber, let buildNumber = buildNumber {
        return "Version \(versionNumber) ( Build \(buildNumber))"
      } else if let versionNumber = versionNumber {
        return versionNumber
      } else if let buildNumber = buildNumber {
        return buildNumber
      } else {
        return ""
      }
    }

    var buildDate: Date {
        if let infoPath = Bundle.main.path(forResource: "Info", ofType: "plist"),
            let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath),
            let infoDate = infoAttr[.modificationDate] as? Date {
            return infoDate
        }
        return Date()
    }
}
