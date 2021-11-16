//
//  LoginViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    private let apiManager = NetworkManager()

    @IBOutlet weak var txtMobileNo:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    @IBOutlet weak var btnEye:UIButton!
    @IBOutlet weak var registration:UIButton!
    @IBOutlet weak var loginWithOTP:UIButton!
    @IBOutlet weak var btnOfficial:UIButton!
    @IBOutlet weak var btnPatient:UIButton!
    @IBOutlet weak var btnLogin:UIButton!
    @IBOutlet weak var imgLogo:UIImageView!
    @IBOutlet weak var imgSlogonTop:UIImageView!
    @IBOutlet weak var btnSegment:UISegmentedControl!
    var segmentSelectedOption:String?
    let serviceUrl = BaseUrl.baseURL + "login"
    var userMobile = ""
    @IBOutlet weak var otpContainerView: UIView!

    var otpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    let otpStackView = OTPStackView()
    
    let serviceURlOTP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/"
    var OTPTokenLogin = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSegment?.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0x1159A7)], for: .normal)
//        self.btnSegment.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0x06284D)], for: .selected)
        self.btnSegment?.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        otpStackView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.txtPassword.text = "abc"
        self.txtMobileNo.text = "9910248968"
    }
    // MARK: - Action Login With Password
    @IBAction func tapToLogin(_ sender:Any){
        if validationCheck() {
            txtMobileNo.resignFirstResponder()
            txtPassword.resignFirstResponder()
            if segmentSelectedOption == "" || segmentSelectedOption == nil{
                segmentSelectedOption = "Patient"
            }
            API_Login(option:segmentSelectedOption!, data: {
                status in
                print(status)
                if status == true{
                    UserDefaults.standard.set("Yes", forKey: "userLoginStatus")
                    UserDefaults.standard.set(self.userMobile, forKey: "userMobile")
                    self.showDashboard()
                }else{
                    UserDefaults.standard.set("No", forKey: "userLoginStatus")
                }
                UserDefaults.standard.synchronize()
            })
        }
    }

    // MARK: - Action Login With OTP

    @IBAction func tapToLoginViaOTP(_ sender:Any){
        print("Final OTP : ",otpStackView.getOTP())
        otpStackView.setAllFieldColor(isWarningColor: true, color: .yellow)

    }
    

    // MARK: - Action Go To Registration
    @IBAction func tapToRegistration(_ sender:Any){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let v1 = storyboard.instantiateViewController(withIdentifier:"RegistrationViewController") as? RegistrationViewController else { return print("Controller is not initiate.") }
//        self.navigationController?.pushViewController(v1, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier:"RegistrationViewController") as? RegistrationViewController
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true

        self.navigationController?.pushViewController(v1!, animated: true)
    }

//    @IBAction func tapToOffical(_ sender:Any){
//
//    }
//
//    @IBAction func tapToPatient(_ sender:Any){
//
//    }
    
    //MARK: - Validation Check
    fileprivate func validationCheck() -> Bool {
        if txtMobileNo.text!.isEmpty {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)
            return false
        } else if txtPassword.text!.isEmpty || txtPassword.text!.count < 3{
            Utility().addAlertView("Alert!", StringConstant.emptyPassword, "OK", self)
            return false
        }
        return true
    }
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch btnSegment.selectedSegmentIndex {
        case 0:
            segmentSelectedOption = "Patient"
            break
            
        case 1:
            segmentSelectedOption = "Official"
            break
           
        default:
            break;
        }

    }
    
    fileprivate func getLoginParams() -> [String: Any] {
        let dictData: [String:Any] = ["username": self.txtMobileNo.text!,
                                      "password": self.txtPassword.text!
                                     ]
        return dictData
    }
    
    
    func API_Login(option:String, data: @escaping (_ result:Bool) -> ()){
        let dictData = getLoginParams()
        print("login",dictData)
        apiManager.apiPostLogin(serviceName: serviceUrl, parameters: dictData, completionHandler: {
            [weak self] (response, error) in
                guard let weakSelf = self else { return }
                if let response = response {
                       let loginJSONModel = try? newJSONDecoder().decode(LoginJSONModel.self, from: response)
                    let status = loginJSONModel?.status.description
                    let datass = loginJSONModel?.response[0].dateOfBirth
                    self?.userMobile = loginJSONModel?.response[0].mobileNumber ?? ""
                    print(datass)
                    if (status == "200") {
                        data(true)
                    }else if (status == "500") {
                        data(false)
                    } else {
                        data(false)
                    }
                }
        })
    }
    
    func showDashboard() {
        var window: UIWindow?

        let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothTab())
        _ = UINavigationController.init(rootViewController: dashboard)
        if #available(iOS 13.0, *) {
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(dashboard)
        } else {
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(dashboard)
        }
    }
    
    func smoothTab() -> [TabItem] {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"DashboardViewController") as? DashboardViewController
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        v2?.tabController = .Profile
      let v3 = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        v3?.tabController = .Setting
      //let v4 = ViewController()
      //v4.tabController = .Profile
      
      
        let t1 = TabItem(v1!, imageName: "home_blue", tabName: "Home")
        let t2 = TabItem(v2!, imageName: "profile", tabName: "Profile")
      let t3 = TabItem(v3!, imageName: "settingIcon", tabName: "Setting")
      //let t4 = TabItem(v4, imageName: "profile", tabName: "Profile")
      
      return [t1,t2,t3]
    }
    
    //MARK:- OTP VIA LOGIN
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
//            proceed()
//        https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/VERIFY/{key}/{otp}
            let baseURLOtP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/VERIFY/"
            let getOTP = self.otpStackView.getOTP()
            let urlVeriftOTP = baseURLOtP + "{" + self.OTPTokenLogin + "}" + "{" + getOTP + "}"
            print("url OTP",urlVeriftOTP)
            self.apiManager.Api_OTP(serviceName: urlVeriftOTP, parameters: [:], completionHandler: {
                [weak self] (response, error) in
                if let response = response {
                    print(response)
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
//                        let token = json?["Details"] as? String

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
    
    func animateViewDown(completion:(() -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.otpView.frame.origin.y = self.view.bounds.height
            self.loginWithOTP.isHidden = false
            self.loginWithOTP.isUserInteractionEnabled = true

            self.view.layoutIfNeeded()
            }, completion: { _ in
                self.otpView.removeFromSuperview()
                completion?()
        })
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
    
    func appearOTPView(){
        loginWithOTP.isUserInteractionEnabled = false
        loginWithOTP.alpha = 1
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: [],
                       animations: {
                        self.loginWithOTP.alpha = 0
        }, completion: { _ in
            self.loginWithOTP.isHidden = true
            proceed()
        })
        
        func proceed() {
            otpView.transform = CGAffineTransform(translationX: 0, y: 445)
            self.otpView.btnVariefy.addTarget(self, action: #selector(self.API_verifyOTP), for: .touchUpInside)
            self.otpView.btnClose.addTarget(self, action: #selector(closeButton), for: .touchUpInside)

            
            animateViewUp()
        }
        
    }
    
    @objc func closeButton(){
        animateViewDown{
            
        }
    }
}

extension LoginViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        self.otpView.btnVariefy.isHidden = !isValid
    }
    
}
