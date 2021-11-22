//
//  BookAppointmentVC.swift
//  Decoy
//
//  Created by MAC on 22/11/21.
//

import UIKit

class BookAppointmentVC: UIViewController {
    @IBOutlet weak var lblFullName:UILabel!
    @IBOutlet weak var lblGender:UILabel!
    @IBOutlet weak var lblAge:UILabel!
    @IBOutlet weak var TopPersonalDetails:UIView!
    @IBOutlet weak var MiddleSearchView:UIView!
    @IBOutlet weak var txtAppointmentDate:UITextField!
    @IBOutlet weak var txtCity:UITextField!
    @IBOutlet weak var txtCamp:UITextField!
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedDate = ""
    
//    var userInfoModels  =  [ResponsesData]()

    var userInfoModels : ResponsesData? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        addArrowBtnToTextFields()
        Utility.addAllSidesShadowOnView(TopPersonalDetails)
        Utility.setViewCornerRadius(TopPersonalDetails, 8)
        Utility.addAllSidesShadowOnView(MiddleSearchView)
        Utility.setViewCornerRadius(MiddleSearchView, 8)
        let name = userInfoModels?.patientName
        self.lblFullName.text = name
        let gend = userInfoModels?.administrativeSexID.administrativeSexCode
        var gender = ""
        switch gend {
        case .f:
            gender = "Female"
        case .m:
            gender = "Male"
        case .none:
            gender = ""
        }
        lblGender.text = gender
        let age = (userInfoModels?.age.description)! + " years"
        lblAge.text = age
        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation
    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool) {

        txtAppointmentDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.touchDown)

      }
    
    @objc func textFieldTouchUP(textfield: UITextField ){
           print("using date")
//        txtAppointmentDate.text = ""
        self.txtAppointmentDate.becomeFirstResponder()
        datePickers()

       }
    
    // MARK: - Navigation
    @IBAction func tapToBackInfo(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
//    var infoViewModel: ResponsesData? {
//        didSet {
//            let name = infoViewModel?.patientName
//            self.lblFullName.text = name
//            let gend = infoViewModel?.administrativeSexID.administrativeSexCode
//            var gender = ""
//            switch gend {
//            case .f:
//                gender = "Female"
//            case .m:
//                gender = "Male"
//            case .none:
//                gender = ""
//            }
//            lblGender.text = gender
//            let age = (infoViewModel?.age.description)! + " years"
//            lblAge.text = age
//        }
//
//    }
    
    fileprivate func addArrowBtnToTextFields() {
        
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        txtAppointmentDate.rightViewMode = UITextField.ViewMode.always
        txtAppointmentDate.rightView = dropDownBtn
        let dropDownBtn1 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn1.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal)
        txtCity.rightViewMode = UITextField.ViewMode.always
        txtCity.rightView = dropDownBtn1
        let dropDownBtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn2.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal)
        txtCamp.rightViewMode = UITextField.ViewMode.always
        txtCamp.rightView = dropDownBtn2
        
    }
    
    func datePickers(){
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle  = .wheels
            datePicker.backgroundColor = .white
        } else {
        }
        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)
        
        toolbar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolbar.barStyle = .blackTranslucent
        toolbar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolbar.sizeToFit()
        self.view.addSubview(toolbar)
    }
    
    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            selectedDate = dateFormatter.string(from: date)
        }
    }
    
    @objc func onDoneButtonClick() {
        if selectedDate == "" {
            self.txtAppointmentDate.text = Date.getCurrentDate()
        }else{
            self.txtAppointmentDate.text = selectedDate
        }
        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
}
