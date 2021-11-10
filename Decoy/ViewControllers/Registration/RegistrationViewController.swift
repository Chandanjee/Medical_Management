//
//  RegistrationViewController.swift
//  Decoy
//
//  Created by MAC on 25/10/21.
//

import UIKit
import Foundation

class RegistrationViewController: UIViewController {
    @IBOutlet weak var txtMobileNo:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtConfirmPassword:UITextField!
    @IBOutlet weak var txtAge:UITextField!
    @IBOutlet weak var txtGender:UITextField!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var btnPrev:UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""

        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation
    @IBAction func tapToBackRegis(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }

}
