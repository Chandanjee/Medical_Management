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
    
    let otpStackView = OTPStackView()
    @IBOutlet weak var otpContainerView: UIView!

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
    // MARK: - Action
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
                    self.showDashboard()
                }else{
                    UserDefaults.standard.set("No", forKey: "userLoginStatus")
                }
                UserDefaults.standard.synchronize()
            })
        }
    }

    @IBAction func tapToLoginViaOTP(_ sender:Any){
        print("Final OTP : ",otpStackView.getOTP())
        otpStackView.setAllFieldColor(isWarningColor: true, color: .yellow)

    }
    
    @IBAction func clickedForHighlight(_ sender: UIButton) {
        print("Final OTP : ",otpStackView.getOTP())
        otpStackView.setAllFieldColor(isWarningColor: true, color: .yellow)
    }
    
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
}

extension LoginViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        testButton.isHidden = !isValid
    }
    
}
