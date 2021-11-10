//
//  RegistrationViewController.swift
//  Decoy
//
//  Created by MAC on 25/10/21.
//

import UIKit
import Foundation
import MBProgressHUD

class RegistrationViewController: UIViewController {
    @IBOutlet weak var txtMobileNo:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtConfirmPassword:UITextField!
    @IBOutlet weak var txtAge:UITextField!
    @IBOutlet weak var txtGender:UITextField!
    @IBOutlet weak var txtName:UITextField!
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var btnPrev:UIButton!
    let registerData = RegisterDetail()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""

        // Do any additional setup after loading the view.
    }
    
    func isAllValid() -> Bool{
        var isValid = false
        let u_email = ValidationClass.verifyPhoneNumber(text: registerData.mobileNumber)
        let u_name = ValidationClass.verifyFirstname(text: txtName.text!)
        let u_age = ValidationClass.verifyLastname(text: txtAge.text!)
        let u_gender = ValidationClass.verifyEmail(text: txtGender.text!)
        let u_contact = ValidationClass.verifyPhoneNumber(text: txtMobileNo.text!)
        let u_password = ValidationClass.verifyPassword(text: txtPassword.text!)
        let u_confirm_pass = ValidationClass.verifyPasswordAndConfirmPassword(password: txtPassword.text!, confirmPassword: txtConfirmPassword.text!)
        
        print("name",u_email)
        print("name",u_name)
        print("u_age",u_age)
        print("u_gender",u_gender)
        print("u_contactMobile",u_contact)
        print("u_password",u_password)
        print("u_confirm_pass",u_confirm_pass)
        
        guard u_name.1 as Bool else {
            return false
        }
        
        guard u_gender.1 as Bool else {
            return false
        }
        
        guard u_age.1 as Bool else {
            return false
        }
        
        guard u_contact.1 else {
            return false
        }
        
        guard u_password.1 as Bool else {
            return false
        }
        
        guard u_confirm_pass.1 else {
            return false
        }
        
        isValid = true
        return isValid
    }


    // MARK: - Navigation
    @IBAction func tapToBackPOP(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapToRegist(_ sender: Any){
        if isAllValid() {
            CallCreateUserApi()
        }
    }
    
    //MARK:- Registration Api
    
    func CallCreateUserApi ()
    {
        MBProgressHUD.showAdded(to: view, animated: true)
        
    }
}


class RegisterDetail  {
 var Name  = ""
 var Gender = ""
 var age = ""
 var mobileNumber  = ""
 var password = ""
 var confirmPAssword = ""
}
