//
//  ForgetPasswordVC.swift
//  Decoy
//
//  Created by Maa on 09/01/22.
//

import UIKit
import  MBProgressHUD

class ForgetPasswordVC: UIViewController {
    @IBOutlet weak var txtMobileNo:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var txtConfirmPassword:UITextField!
    @IBOutlet weak var btnOTP:UIButton!
    @IBOutlet weak var btnPasswordSubmit:UIButton!
    @IBOutlet weak var viewPassword:UIView!

    var OTPToken = ""
    private let apiManager = NetworkManager()
    let baseURLOtP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/VERIFY/"
    let serviceURlOTP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/"
    var OTPTokenLogin = ""
    let serviceUrl = BaseUrl.baseURL + "admin/" + "forgetPassword"

    var otpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    let otpStackView = OTPStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true
        viewPassword.isHidden = true
        self.btnOTP.isUserInteractionEnabled = false

        // Do any additional setup after loading the view.
    }
    
    
    func setupViews() {
        self.otpView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 335 , width: UIScreen.main.bounds.width, height:335 )
    }
    
    // MARK: - Navigation
    @IBAction func tapToBackPOP(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }

    
    @IBAction func tapToRegist(_ sender: Any){
        if txtMobileNo.state.isEmpty{
           
        }
    }
    
    func appearOTPView(){
        btnOTP.isUserInteractionEnabled = false
        btnOTP.alpha = 1
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: {
                        self.btnOTP.alpha = 0
        }, completion: { _ in
            self.btnOTP.isHidden = true
            proceed()
        })
        
        func proceed() {
            otpView.transform = CGAffineTransform(translationX: 0, y: 445)
            self.otpView.btnVariefy.addTarget(self, action: #selector(self.createRegistrationContniue), for: .touchUpInside)
            self.otpView.btnClose.addTarget(self, action: #selector(closeButton), for: .touchUpInside)
            animateViewUp()
        }
        
    }

    //MARK:- Animated View
    func animateViewUp() {

        UIView.animate(withDuration: 1.0, delay: 1, options: [.curveLinear], animations: {
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
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.otpView.frame.origin.y = self.view.bounds.height
            self.btnOTP.isHidden = false
            self.btnOTP.isUserInteractionEnabled = true
            self.btnOTP.alpha = 1

            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.otpView.removeFromSuperview()
                completion?()
        })
    }
    
    @objc func closeButton(){
        animateViewDown{
            
        }
    }
    
    //MARK:- Button Continue
    @objc func createRegistrationContniue() {
        animateViewDown {
            
        }
    }
    
    @IBAction func tapToSubmit(_ sender:Any){
        guard let password = txtPassword.text, !password.isEmpty,
            let confirm = txtConfirmPassword.text, !confirm.isEmpty else {
                Utility().addAlertView("Alert!", "Password Field is empty", "OK", self)
                return
        }
        guard password == confirm else {
            Utility().addAlertView("Alert!", "Passwords Do Not Match", "OK", self)

            return
        }
        
        API_Submit(option: "", data:  {
            status in
            print(status)
            if status == true{
                self.txtPassword.text = ""
                self.txtConfirmPassword.text = ""
                self.navigationController?.popViewController(animated: true)
            }else{
                Utility().addAlertView("Alert!", "Please try again later", "OK", self)

            }
        })
    }
    
    @IBAction func tapToGenerateOTP(_ sender:Any){
        if validationCheck() {
             if !(txtMobileNo.text!.containsNumberOnly()) {

            }
            txtMobileNo.resignFirstResponder()
            otpView.lblNumberTitle.text = "Enter the code sent to you at " + "+91\(txtMobileNo.text!)"
            setupViews()
            appearOTPView()
            API_RegisterOTP()
        }
    }
    
    //MARK: - Validation Check
    fileprivate func validationCheck() -> Bool {
        if txtMobileNo.text!.isEmpty || txtMobileNo.text! == "" || txtMobileNo.text!.count < 10  {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)
            return false
        }
        return true
    }
    
    func isPasswordValid(_ password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    
    //MARK:- Get OTP
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
                    self?.OTPTokenLogin = token!
                    print(json as Any)
                }catch{ print("erroMsg") }
            }else if (error != nil) {
                print(error as Any)
            } else {
                print(error as Any)
            }
        })
    }
    
    //MARK:- OTP Verify
    @objc  func API_verifyOTP(){
        animateViewDown {
            let getOTP = self.otpStackView.getOTP()
            MBProgressHUD.showAdded(to: self.view, animated: true)
            if getOTP.count < 6 {
                print("Get otp is less then 6")
            }else if getOTP != ""{
                let urlVeriftOTP = self.baseURLOtP + self.OTPTokenLogin + "/" + getOTP
            print("url OTP",urlVeriftOTP)
            self.apiManager.Api_OTP(serviceName: urlVeriftOTP, parameters: [:], completionHandler: {
                [weak self] (response, error) in
                if let response = response {
                    print(response)
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let status = json?["Status"] as? String
                        if status == "Success" {
                            self?.viewPassword.isHidden = false
                            self?.btnOTP.isUserInteractionEnabled = false
                            self?.btnOTP.alpha = 0.5


//                            UserDefaults.standard.set(self?.txtMobileNo.text, forKey: "LoginMobilenum")
//                            UserDefaults.standard.set("", forKey: "Username")
//                            UserDefaults.standard.set("", forKey: "emailAddress")

                            MBProgressHUD.hide(for: (self?.view)!, animated: true)
                        }
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
    }
    //MARK: - Dictionary for login
    fileprivate func getParams() -> [String: Any] {
        let dictData: [String:Any] = ["username": self.txtMobileNo.text!,
                                      "password": self.txtConfirmPassword.text!
                                     ]
        return dictData
    }
    
    //MARK: - Submit
    func API_Submit(option:String, data: @escaping (_ result:Bool) -> ()){
        let dictData = getParams()
        print("login",dictData,serviceUrl)
        MBProgressHUD.showAdded(to: view, animated: true)
        apiManager.apiPostLogin(serviceName: serviceUrl, parameters: dictData, completionHandler: {
            [weak self] (response, error) in
                guard let weakSelf = self else { return }
                if let response = response {
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let loginStatus = json?["status"] as? NSNumber
                        let loginMsg = json?["message"] as? String
                        if loginStatus == 400 {
                            Utility().addAlertView("Alert!", "Incorrect user credentials", "OK", self!)
                            MBProgressHUD.hide(for: (self?.view)!, animated: true)
                            data(false)
                            return
                        }
                        if (loginStatus == 200) {
                            data(true)
                        }else if (loginStatus == 500) {
                            data(false)
                        } else {
                            data(false)
                        }
                        print(json as Any)
                    }catch{ print("erroMsg") }
              
                    MBProgressHUD.hide(for: (self?.view)!, animated: true)
                    
                }else{
                    Utility().addAlertView("Alert!", "Server error", "OK", self!)
                    MBProgressHUD.hide(for: (self?.view)!, animated: true)
                }
        })
    }
}

extension ForgetPasswordVC: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        self.otpView.btnVariefy.isHidden = !isValid
    }
    
}
