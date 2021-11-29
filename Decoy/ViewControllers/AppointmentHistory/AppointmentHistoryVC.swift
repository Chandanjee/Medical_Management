//
//  AppointmentHistoryVC.swift
//  Decoy
//
//  Created by MAC on 28/11/21.
//

import UIKit

class AppointmentHistoryVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var fromDateTxt:UITextField!
    @IBOutlet weak var toDateTxt:UITextField!
    @IBOutlet weak var searchButton:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let image = UIImage(named: "imageName")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        } else {
            // Fallback on earlier versions
        }
//        theImageView.image = theImageView.image?.withRenderingMode(.alwaysTemplate)
//        theImageView.tintColor = UIColor.red
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

}
