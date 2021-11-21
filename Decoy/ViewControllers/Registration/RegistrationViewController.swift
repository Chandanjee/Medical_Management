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
    
    var OTPToken = ""
    let registerData = RegisterDetail()
    private let apiManager = NetworkManager()
    let serviceUrlRegis = BaseUrl.baseURL + "login"
//https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/9897040757/AUTOGEN/MMULOGIN
    let serviceURlOTP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/"
    @IBOutlet weak var logoImageView: UIImageView!{
        didSet{
            self.logoImageView.center.y  = self.logoImageView.center.y + 40
        }
    }
    
    var otpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    let otpStackView = OTPStackView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""

        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        self.otpView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 335 , width: UIScreen.main.bounds.width, height:335 )
    }
    
    func isAllValid() -> Bool{
        var isValid = false
        let u_email = ValidationClass.verifyPhoneNumber(text: registerData.mobileNumber)
        let u_name = ValidationClass.verifyFirstname(text: txtName.text!)
        let u_age = ValidationClass.verifyYears(text: txtAge.text!)
        let u_gender = ValidationClass.verifyGender(text: txtGender.text!)
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
            Utility().addAlertView("Alert!", "Please check username.", "OK", self)
            return false
        }
        
        guard u_gender.1 as Bool else {
            Utility().addAlertView("Alert!", "Please fullfil gender", "OK", self)
            return false
        }
        
        guard u_age.1 as Bool else {
            Utility().addAlertView("Alert!", "Please check age.", "OK", self)
            return false
        }
        
        guard u_contact.1 else {
            Utility().addAlertView("Alert!", "Please set 10 digit number.", "OK", self)
            return false
        }
        
        guard u_password.1 as Bool else {
            Utility().addAlertView("Alert!", "Please check password.", "OK", self)
            return false
        }
        
        guard u_confirm_pass.1 else {
            Utility().addAlertView("Alert!", "Please set same password.", "OK", self)

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
            appearOTPView()
            API_RegisterOTP()
//            CallCreateUserApi()
        }
    }
    
    //MARK:- Registration Api
    
    func CallCreateUserApi ()
    {
        MBProgressHUD.showAdded(to: view, animated: true)
        apiManager.apiPostView(serviceName: "", parameters: [:], completionHandler: {
            [weak self] (response, error) in
            if let response = response {
                print(response)
            }
        })
    }
    
    func appearOTPView(){
        btnSubmit.isUserInteractionEnabled = false
        btnSubmit.alpha = 1
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: {
                        self.btnSubmit.alpha = 0
        }, completion: { _ in
            self.btnSubmit.isHidden = true
            proceed()
        })
        
        func proceed() {
            otpView.transform = CGAffineTransform(translationX: 0, y: 445)
            self.otpView.btnVariefy.addTarget(self, action: #selector(self.createRegistrationContniue), for: .touchUpInside)
            self.otpView.btnClose.addTarget(self, action: #selector(closeButton), for: .touchUpInside)

//            self.otpView.btnClose.addTarget(self, action: #selector(createRegistrationNotification(_:)), for: .touchUpInside)
//            self.otpView._txtCountryName.addTarget(self, action: #selector(self.createCountryName), for: .touchUpInside)
            
            animateViewUp()
        }
        
    }
    
    //MARK:- Animated View
    func animateViewUp() {
//        let diff = self.logoImageView.frame.maxY - (self.view.frame.height - self.otpView.frame.height)
//        let isCountryPickerOverlapLogo = diff > 0
//        if isCountryPickerOverlapLogo {
////            self.logoImageViewCenterY.constant = -diff-70
//        }
        UIView.animate(withDuration: 1.0, delay: 1, options: [.curveLinear], animations: {
//            self.blackColor!.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            self.otpView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.view.layoutIfNeeded()
        }, completion:nil)
        otpView.viewOtps.addSubview(otpStackView)
        otpStackView.delegate = self
        otpStackView.heightAnchor.constraint(equalTo: otpView.viewOtps.heightAnchor).isActive = true
        otpStackView.centerXAnchor.constraint(equalTo: otpView.viewOtps.centerXAnchor).isActive = true
        otpStackView.centerYAnchor.constraint(equalTo: otpView.viewOtps.centerYAnchor).isActive = true
        self.view.addSubview(otpView)
    }
    
    
    func animateViewDown(completion:(() -> Void)?) {
//        self.logoImageViewCenterY.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
//            self.blackColor!.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.otpView.frame.origin.y = self.view.bounds.height
            self.btnSubmit.isHidden = false
            self.btnSubmit.isUserInteractionEnabled = true

            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.otpView.removeFromSuperview()
                completion?()
        })
    }
    
    
    //MARK:- Button Continue
    @objc func createRegistrationContniue() {
        animateViewDown {
//            proceed()
//        https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/VERIFY/{key}/{otp}
            let baseURLOtP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/VERIFY/"
            let getOTP = self.otpStackView.getOTP()
            MBProgressHUD.showAdded(to: self.view, animated: true)

            let urlVeriftOTP = baseURLOtP + "{" + self.OTPToken + "}" + "{" + getOTP + "}"
            print("url OTP",urlVeriftOTP)
            self.apiManager.Api_OTP(serviceName: urlVeriftOTP, parameters: [:], completionHandler: {
                [weak self] (response, error) in
                if let response = response {
                    print(response)
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let token = json?["status"] as? String
//                        self?.OTPToken = token!
                        self?.API_Registration()
                        print(json as Any)
                    }catch{ print("erroMsg") }
                }else if (error != nil) {
                    print(error as Any)
                } else {
                    print(error as Any)
                }
            })
        }
    }
    
    @objc func closeButton(){
        animateViewDown{
            
        }
    }
    
    fileprivate func getRegisParams() -> [String: Any] {
        let dob = self.txtAge.text
        let dictData: [String:Any] = ["age": self.txtAge.text!,
                                      "dateOfBirth": dob,
                                      "gender": self.txtGender.text!,
                                      "mobileNumber": self.txtMobileNo.text!,
                                      "password": self.txtPassword.text!,
                                      "patientName": self.txtName.text!,
                                      "religenID": "1"
                                     ]
        return dictData
    }
    
//    func API_Registration(option:String, data: @escaping (_ dataStore:Bool) -> ()){
    func API_Registration(){
        let dictData = getRegisParams()
        print("Registration Json",dictData)
        apiManager.apiPostView(serviceName: serviceUrlRegis, parameters: dictData, completionHandler: {
            [weak self] (response, error) in
            if let response = response {
                print(response)
                MBProgressHUD.hide(for: (self?.view)!, animated: true)

            }
            
        })

    }
    
    //MARK:- OTP Registration
    func API_RegisterOTP(){
        if self.txtMobileNo.text == "" {
            Utility().addAlertView("Alert!", "Check your mobile number.", "OK", self)

            return
        }
        let urlWithMobile = serviceURlOTP + self.txtMobileNo.text! + "/AUTOGEN/MMULOGIN"
        print("url OTP",urlWithMobile)
        apiManager.Api_OTP(serviceName: urlWithMobile, parameters: [:], completionHandler: {
            [weak self] (response, error) in
            if let response = response {
                print(response)
                do{
                let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                    let token = json?["Details"] as? String
                    self?.OTPToken = token!
                    print(json as Any)
                }catch{ print("erroMsg") }
            }else if (error != nil) {
                print(error as Any)
            } else {
                print(error as Any)
            }
        })
    }
    
   
}

extension RegistrationViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        self.otpView.btnVariefy.isHidden = !isValid
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
