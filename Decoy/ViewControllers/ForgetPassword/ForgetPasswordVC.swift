//
//  ForgetPasswordVC.swift
//  Decoy
//
//  Created by Maa on 09/01/22.
//

import UIKit

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
    
    
    var otpView = Bundle.main.loadNibNamed("OTPView", owner: self, options: nil)?.first as! OTPView
    let otpStackView = OTPStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        self.navigationController?.hidesBarsOnTap = true
        self.navigationController?.navigationBar.isHidden = true
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
        
    }
    
    @IBAction func tapToGenerateOTP(_ sender:Any){
        if validationCheck() {
            txtMobileNo.resignFirstResponder()
            otpView.lblNumberTitle.text = "Enter the code sent to you at " + "+91\(txtMobileNo.text!)"
            setupViews()
            appearOTPView()
        }
    }
    
    //MARK: - Validation Check
    fileprivate func validationCheck() -> Bool {
        if txtMobileNo.text!.isEmpty || txtMobileNo.text!.count < 10  {
            Utility().addAlertView("Alert!", StringConstant.emptyUsername, "OK", self)
            return false
        }
        return true
    }
}

extension ForgetPasswordVC: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        self.otpView.btnVariefy.isHidden = !isValid
    }
    
}
