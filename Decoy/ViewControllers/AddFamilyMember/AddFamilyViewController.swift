//
//  AddFamilyViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 18/10/21.
//

import UIKit
import MBProgressHUD

class AddFamilyViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nameTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    @IBOutlet weak var ageTxt:UITextField!
    @IBOutlet weak var mobilenumberTxt:UITextField!
    @IBOutlet weak var submitButton:UIButton!
    @IBOutlet weak var backButton:UIButton!
    
    @IBOutlet weak var btnYear: UIButton!
        @IBOutlet weak var btnMonth: UIButton!
        @IBOutlet weak var btnDays: UIButton!
    var arrGenderID = [String]()
    var arrGenderName = [String]()
    var selectedGender = ""
    private let apiManager = NetworkManager()

    let radioController: RadioButtonController = RadioButtonController()
    let serviceURLGender = BaseUrl.baseURL + "getAllRelation"
    let serviceUrlAddFamily = BaseUrl.baseURL + "createPatient"
    override func viewDidLoad() {
        super.viewDidLoad()
        addArrowBtnToTextFields()
        getGender_API()
        // Do any additional setup after loading the view.
        genderTxt.loadDropdownData(data: ["Select","Male","Female","Others"])
        radioController.buttonsArray = [btnYear,btnMonth,btnDays]
        radioController.defaultButton = btnYear
        selectedGender = "Years"
        
    }
    
    //MARK: Add Arrow on TextField
    fileprivate func addArrowBtnToTextFields() {
        
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        genderTxt.rightViewMode = UITextField.ViewMode.always
        genderTxt.rightView = dropDownBtn
        
        let image = UIImage(named: "back")
        backButton.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        backButton.tintColor = UIColor.white
    }
   
    
    @IBAction func btnbackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
     }
    
    @IBAction func btnYearAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
        selectedGender = "Years"
     }

     @IBAction func btnMonthsAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
         selectedGender = "month"
     }

     @IBAction func btnDaysAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
         selectedGender = "days"
     }
    
    @IBAction func btnAddFamily(_ sender:Any){
        if (self.nameTxt.text?.isEmpty == true) {
            Utility().addAlertView("Alert!", "Enter your name.", "ok", self)
            return
        }else if (self.genderTxt.text?.isEmpty == true) || (self.genderTxt.text == "Select"){
            Utility().addAlertView("Alert!", "Select your gender.", "ok", self)
            return
        }else if (self.ageTxt.text?.isEmpty == true){
            Utility().addAlertView("Alert!", "Enter your age.", "ok", self)
            return
        }else{
            let u_contact = ValidationClass.verifyPhoneNumber(text: mobilenumberTxt.text!)
            guard u_contact.1 else {
                Utility().addAlertView("Alert!", "Please set 10 digit number.", "OK", self)
                return
            }
            API_Registration()
        }
        
    }
    
    //MARK: Gender Api
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
                        self.genderTxt.loadDropdownData(data: self.arrGenderName)
                    }
                }catch{ print("erroMsg") }
                
            }else{
                print(error)
            }
            
        })
    }
    
    fileprivate func getRegisORAddFamilyParams() -> [String: Any] {
        let dob = self.ageTxt.text
        let ageInt = Int(dob!)
        var date: Date? = nil
        if selectedGender == "Years" {
            date = Calendar.current.date(byAdding: .year, value: -ageInt!, to: Date())

        } else if selectedGender == "month"{
            date = Calendar.current.date(byAdding: .month, value: -ageInt!, to: Date())
        }else if selectedGender == "days"{
            date = Calendar.current.date(byAdding: .day, value: -ageInt!, to: Date())
        }
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd"  //1986-11-13
        let timeFromDate = dateFormatter.string(from: date!)
print(timeFromDate)
        let index =  arrGenderName.firstIndex(where: { $0 == self.genderTxt.text }) ?? 0
        let nameID =  arrGenderID[index]
        let password = UserDefaults.standard.value(forKey: "LoginPassword") as? String
        let dictData: [String:Any] = ["age": self.ageTxt.text!,
                                      "dateOfBirth": timeFromDate,
                                      "gender": nameID,
                                      "mobileNumber": self.mobilenumberTxt.text!,
                                      "password": password ?? "",
                                      "patientName": self.nameTxt.text!,
                                      "religenID": "1"
                                     ]
        return dictData
    }
    
    func API_Registration(){
        let dictData = getRegisORAddFamilyParams()
        print("Registration Json",dictData)
        apiManager.apiPostView(serviceName: serviceUrlAddFamily, parameters: dictData, completionHandler: {
            [weak self] (response, error) in
            if let response = response {
                print(response)
                do{
                    let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                    print(json as Any)
                    let status = json?["status"] as? NSNumber
                    let msg = json?["message"] as? String
                    
                    if status == 200 {
                        MBProgressHUD.hide(for: (self?.view)!, animated: true)
                        self?.navigationController?.popViewController(animated: true)
                    }
                    if status == 401 {
                        MBProgressHUD.hide(for: (self?.view)!, animated: true)
                        Utility().addAlertView("Alert!", msg ?? "", "ok", self!)
                        return
                    }
                }catch{ print("erroMsg") }
                MBProgressHUD.hide(for: (self?.view)!, animated: true)

            }
            
        })

    }
}
