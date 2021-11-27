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
    
    var arrGenderID = [String]()
    var arrGenderName = [String]()
    var OTPToken = ""
    let registerData = RegisterDetail()
    private let apiManager = NetworkManager()
    let serviceUrlRegis = BaseUrl.baseURL + "login"
    let serviceURLGender = BaseUrl.baseURL + "getAllRelation"
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
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true
        getGender_API()
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        txtGender.rightViewMode = UITextField.ViewMode.always
        txtGender.rightView = dropDownBtn
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
            otpView.lblNumberTitle.text = "Enter the code sent to you at " + "+91\(txtMobileNo.text!)"
            setupViews()
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
            self.btnSubmit.alpha = 1

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

            let urlVeriftOTP = baseURLOtP + self.OTPToken + "/" + getOTP
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
        let ageInt = Int(dob!)
        let date = Calendar.current.date(byAdding: .year, value: -ageInt!, to: Date())
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"  //1986-11-13
        let timeFromDate = dateFormatter.string(from: date!)
print(timeFromDate)
        let index =  arrGenderName.firstIndex(where: { $0 == self.txtGender.text }) ?? 0
        let nameID =  arrGenderID[index]
        let dictData: [String:Any] = ["age": self.txtAge.text!,
                                      "dateOfBirth": timeFromDate,
                                      "gender": nameID,
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
    
    func getGender_API(){
        apiManager.Api_GetWithData(serviceName: serviceURLGender, parameters: [:], completionHandler: {(result,error) in
            if let responses = result {
                print(responses)
                do{
                    let json = try JSONSerialization.jsonObject(with: responses, options: []) as? [String : Any]
                    //                    print(json?["response"] as? Array<Any>)
                    let arrData =  json?["response"] as? [[String:Any]]
                    
                    var firstitem: Bool = false
                    if  arrData?.count ?? 0 > 0{
                        //                Loader.hideLoader(self)
                        if let datasss = arrData {
                            for itemss in datasss {
                                print(itemss)
                                let nameGender = itemss["administrativeSexName"] as? String
                                let idGender = itemss["administrativeSexId"] as? Int
                                if firstitem == false {
                                    firstitem = true
                                    self.arrGenderID.append("Select")
                                    self.arrGenderName.append("Select")
                                    self.arrGenderID.append(String(idGender!))
                                    self.arrGenderName.append(nameGender!)
                                }else{
                                    self.arrGenderID.append(String( idGender! ))
                                    self.arrGenderName.append(nameGender!)
                                }
                            }
                        }
                        self.txtGender.loadDropdownData(data: self.arrGenderName)
                    }
                }catch{ print("erroMsg") }
                
            }else{
                print(error)
            }
            
        })
    }
    
}

extension RegistrationViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        self.otpView.btnVariefy.isHidden = !isValid
    }
    
}

extension RegistrationViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called\(textField.text!)")
        if (textField.tag == 111){
//            textFieldEditingDidChange(self)
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
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
