//
//  LoginViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//

import UIKit
import MBProgressHUD

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
    let serviceUrlOfficial = BaseUrl.baseURL + "loginOffical"

    var userMobile = ""
    @IBOutlet weak var backContainerView: UIView!

    var otpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    let otpStackView = OTPStackView()
    
    let serviceURlOTP = "https://2factor.in/API/V1/5cdc6365-22b5-11ec-a13b-0200cd936042/SMS/"
    var OTPTokenLogin = ""

    let getpatientList = BaseUrl.baseURL + "getPatientList"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnSegment?.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0x1159A7)], for: .normal)
//        self.btnSegment.setTitleTextAttributes([.foregroundColor: UIColor.init(rgb: 0x06284D)], for: .selected)
        self.btnSegment?.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
//        otpStackView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        self.otpView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 335 , width: UIScreen.main.bounds.width, height:335 )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.txtPassword.text = "9971182412"
//        self.txtMobileNo.text = "9910248968"
//        self.txtMobileNo.text = "9897040757" // deepak
        self.txtMobileNo.text = "9971182412"

    }
    // MARK: - Action Login With Password
    @IBAction func tapToLogin(_ sender:Any){
        if validationCheck() {
            txtMobileNo.resignFirstResponder()
            txtPassword.resignFirstResponder()
            if segmentSelectedOption == "" || segmentSelectedOption == nil{
                segmentSelectedOption = "Patient"
            }
            if segmentSelectedOption == "Official" {
                
            }else{
            API_Login(option:segmentSelectedOption!, data: {
                status in
                print(status)
                if status == true{
                    UserDefaults.standard.set("Yes", forKey: "userLoginStatus")
                    UserDefaults.standard.set(self.userMobile, forKey: "userMobile")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.showDashboard()
                }else{
                    UserDefaults.standard.set("No", forKey: "userLoginStatus")
                }
                UserDefaults.standard.synchronize()
            })
            }
            
        }
    }

    // MARK: - Action Login With OTP

    @IBAction func tapToLoginViaOTP(_ sender:Any){
//        print("Final OTP : ",otpStackView.getOTP())
//        otpStackView.setAllFieldColor(isWarningColor: true, color: .yellow)
//        Enter the code sent to you at +916966366466
        if txtMobileNo.text!.isEmpty {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)
        } else if !(txtMobileNo.text!.containsNumberOnly()) {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)

        }else if !(txtMobileNo.text!.count == 10) {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)

        }else{
            //Enter the code sent to you at +916966366466
            otpView.lblNumberTitle.text = "Enter the code sent to you at " + "+91\(txtMobileNo.text!)"
            print(otpView.lblNumberTitle.text as Any)
            setupViews()
        appearOTPView()
        API_RegisterOTP()
        }
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
    
    
    //MARK: - Segment Selection
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
    
    //MARK: - Dictionary for login
    fileprivate func getLoginParams() -> [String: Any] {
        let dictData: [String:Any] = ["username": self.txtMobileNo.text!,
                                      "password": self.txtPassword.text!
                                     ]
        return dictData
    }
    
    //MARK: - Login
    func API_Login(option:String, data: @escaping (_ result:Bool) -> ()){
        let dictData = getLoginParams()
        print("login",dictData)
        MBProgressHUD.showAdded(to: view, animated: true)
        UserDefaults.standard.set(self.segmentSelectedOption, forKey: "LoginMode")
        apiManager.apiPostLogin(serviceName: serviceUrl, parameters: dictData, completionHandler: {
            [weak self] (response, error) in
                guard let weakSelf = self else { return }
                if let response = response {
                       let loginJSONModel = try? newJSONDecoder().decode(LoginJSONModel.self, from: response)
                    let status = loginJSONModel?.status.description
                    let datass = loginJSONModel?.response[0].dateOfBirth
                    self?.userMobile = loginJSONModel?.response[0].mobileNumber ?? ""
                    let patientId = loginJSONModel?.response[0].patientID
                    let Password = loginJSONModel?.response[0].loginPwd
                    let name = loginJSONModel?.response[0].patientName

                    print(datass as Any)
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let loginStatus = json?["status"] as? NSNumber
                        let loginMsg = json?["message"] as? String
                        if loginStatus == 400 {
                            Utility().addAlertView("Alert!", "Incorrect user credentials", "OK", self!)
                            MBProgressHUD.hide(for: (self?.view)!, animated: true)
                            return
                        }
                        print(json as Any)
                    }catch{ print("erroMsg") }
                    if (status == "200") {
                        UserDefaults.standard.set(patientId, forKey: "patientId")
                       
                        UserDefaults.standard.set(Password, forKey: "LoginPassword")
                        UserDefaults.standard.set(self?.txtMobileNo.text, forKey: "LoginMobilenum")
                        UserDefaults.standard.set(name, forKey: "Username")

                        data(true)
                    }else if (status == "500") {
                        data(false)
                    } else {
                        data(false)
                    }
                    MBProgressHUD.hide(for: (self?.view)!, animated: true)
                    
                }else{
                    Utility().addAlertView("Alert!", "Server error", "OK", self!)
                    MBProgressHUD.hide(for: (self?.view)!, animated: true)
                }
        })
    }
    
    //MARK: Official Login
    
    func API_officialLogin(){
        let dictData = getLoginParams()
        UserDefaults.standard.set(self.segmentSelectedOption, forKey: "LoginMode")

        apiManager.apiPostLogin(serviceName: serviceUrlOfficial, parameters: dictData, completionHandler: {[weak self](result,error) in
            if let responsed = result {
                print(responsed)

                let loginJSONModel = try? newJSONDecoder().decode(LoginOfficialResponse.self, from: responsed)
                UserDefaults.standard.set(self?.txtMobileNo.text, forKey: "LoginMobilenum")
                UserDefaults.standard.set(loginJSONModel?.response.userName, forKey: "Username")
                
                do{
                let json = try JSONSerialization.jsonObject(with: responsed, options: []) as? [String : Any]
                    let loginStatus = json?["status"] as? NSNumber
                    let loginMsg = json?["message"] as? String
                    if loginStatus == 400 {
                        Utility().addAlertView("Alert!", "Incorrect user credentials", "OK", self!)
                        MBProgressHUD.hide(for: (self?.view)!, animated: true)
                        return
                    }
                    print(json as Any)
                }catch{ print("erroMsg") }
            }else{
                Utility().addAlertView("Alert!", "Server error", "OK", self!)
                MBProgressHUD.hide(for: (self?.view)!, animated: true)
            }
        })
    }
    
    func showDashboard() {
        var _: UIWindow?
        if segmentSelectedOption == "Patient" {
            let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothTab())
            _ = UINavigationController.init(rootViewController: dashboard)
            if #available(iOS 13.0, *) {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(dashboard)
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(dashboard)
            }
        }else{
            let dashboard = AppTabBarViewController.init(nibName: "AppTabBarViewController", bundle: nil,smoothData: smoothOfficialTab())
            _ = UINavigationController.init(rootViewController: dashboard)
            if #available(iOS 13.0, *) {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(dashboard)
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(dashboard)
            }
        }
        
       
    }
    
    //MARK: Patient Login Tab
    func smoothTab() -> [TabItem] {
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"DashboardViewController") as? DashboardViewController
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        v2?.tabController = .Setting
      let v3 = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController
        v3?.tabController = .Profile
      //let v4 = ViewController()
      //v4.tabController = .Profile
      
      
        let t1 = TabItem(v1!, imageName: "home_blue", tabName: "Home")
        let t2 = TabItem(v3!, imageName: "profile", tabName: "Profile")
      let t3 = TabItem(v2!, imageName: "settingIcon", tabName: "Setting")
      //let t4 = TabItem(v4, imageName: "profile", tabName: "Profile")
      
      return [t1,t2,t3]
    }
    
    //MARK: Official Tab Bar
    func smoothOfficialTab() -> [TabItem] {
        
     let storyboard = UIStoryboard(name: "Main", bundle: nil)
     let v1 = storyboard.instantiateViewController(withIdentifier:"OfficialDashboardVC") as? OfficialDashboardVC
        v1?.tabController = .Home
      let v2 =  storyboard.instantiateViewController(withIdentifier: "AnalyticReportVC") as? AnalyticReportVC
        v2?.tabController = .Profile
        let v3 =  storyboard.instantiateViewController(withIdentifier: "PendingApprovalVC") as? PendingApprovalVC
          v3?.tabController = .Setting
        let v4 =  storyboard.instantiateViewController(withIdentifier: "PandemicZoneVC") as? PandemicZoneVC
          v4?.tabController = .Menu
      let v5 = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as? ProfileViewController
        v5?.tabControllerss = .Dummy
      
      
        let t1 = TabItem(v1!, imageName: "dashboard", tabName: "Dashboard")
        let t2 = TabItem(v2!, imageName: "reportAnalysis", tabName: "Analytic Report")
        let t3 = TabItem(v3!, imageName: "medical_supply", tabName: "Pending Approval")
        let t4 = TabItem(v4!, imageName: "pandemic", tabName: "Pandemic Zone")
        let t5 = TabItem(v5!, imageName: "profile", tabName: "Profile")
      
      return [t1,t2,t3,t4,t5]
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
            MBProgressHUD.showAdded(to: self.view, animated: true)
            if getOTP.count < 6 {
                print("Get otp is less then 6")
            }else if getOTP != ""{
                UserDefaults.standard.set(self.segmentSelectedOption, forKey: "LoginMode")
            let urlVeriftOTP = baseURLOtP + self.OTPTokenLogin + "/" + getOTP
            print("url OTP",urlVeriftOTP)
            self.apiManager.Api_OTP(serviceName: urlVeriftOTP, parameters: [:], completionHandler: {
                [weak self] (response, error) in
                if let response = response {
                    print(response)
                    do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let status = json?["Status"] as? String
                        if status == "Success" {
                            UserDefaults.standard.set(self?.txtMobileNo.text, forKey: "LoginMobilenum")
                            
                            MBProgressHUD.hide(for: (self?.view)!, animated: true)
                            self?.showDashboard()
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
    
    func animateViewDown(completion:(() -> Void)?) {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.curveEaseOut], animations: {
            self.otpView.frame.origin.y = self.view.bounds.height
            self.loginWithOTP.isHidden = false
            self.loginWithOTP.alpha = 1
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
        self.backContainerView.addSubview(otpView)
//        self.view.insertSubview(otpView, aboveSubview: backContainerView)
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
