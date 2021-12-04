//
//  AddFamilyViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 18/10/21.
//

import UIKit

class AddFamilyViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var nameTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    @IBOutlet weak var ageTxt:UITextField!
    @IBOutlet weak var mobilenumberTxt:UITextField!
    @IBOutlet weak var submitButton:UIButton!
    
    @IBOutlet weak var btnYear: UIButton!
        @IBOutlet weak var btnMonth: UIButton!
        @IBOutlet weak var btnDays: UIButton!
    var arrGenderID = [String]()
    var arrGenderName = [String]()
    private let apiManager = NetworkManager()

    let radioController: RadioButtonController = RadioButtonController()
    let serviceURLGender = BaseUrl.baseURL + "getAllRelation"

    override func viewDidLoad() {
        super.viewDidLoad()
        addArrowBtnToTextFields()
        getGender_API()
        // Do any additional setup after loading the view.
        genderTxt.loadDropdownData(data: ["Select","Male","Female","Others"])
        radioController.buttonsArray = [btnYear,btnMonth,btnDays]
              radioController.defaultButton = btnYear
    }
    
    //MARK: Add Arrow on TextField
    fileprivate func addArrowBtnToTextFields() {
        
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        genderTxt.rightViewMode = UITextField.ViewMode.always
        genderTxt.rightView = dropDownBtn
        
    }
   
    
    @IBAction func btnYearAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
     }

     @IBAction func btnMonthsAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
     }

     @IBAction func btnDaysAction(_ sender: UIButton) {
         radioController.buttonArrayUpdated(buttonSelected: sender)
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
}
