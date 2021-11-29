//
//  AppointmentHistoryVC.swift
//  Decoy
//
//  Created by MAC on 28/11/21.
//

import UIKit
import MBProgressHUD

class AppointmentHistoryVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var fromDateTxt:UITextField!
    @IBOutlet weak var toDateTxt:UITextField!
    @IBOutlet weak var searchButton:UIButton!
    
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedDate = ""
    private let apiManager = NetworkManager()

    let serviceURL = BaseUrl.baseURL + "getDataFromPatientIdAndDates"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            let image = UIImage(named: "imageName")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        } else {
            // Fallback on earlier versions
        }
//        theImageView.image = theImageView.image?.withRenderingMode(.alwaysTemplate)
//        theImageView.tintColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation


    
    override func viewWillAppear(_ animated: Bool) {
        
        //        txtAppointmentDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.touchDown)
        fromDateTxt.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.editingDidBegin)
        toDateTxt.addTarget(self, action: #selector(toDatetextFieldTouchUP), for: UIControl.Event.editingDidBegin)
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.reloadData()
        
    }
    
    //MARK: Date Picker

    func datePickers(){
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.minimumDate = Date()
        
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
            if (self.fromDateTxt.tag == 1001) {
                self.fromDateTxt.text = Date.getCurrentDate()
            }else if (self.toDateTxt.tag == 1002){
            self.toDateTxt.text = Date.getCurrentDate()
            }
        }else{
            if (self.fromDateTxt.tag == 1001) {
                self.fromDateTxt.text = selectedDate
            }else if (self.toDateTxt.tag == 1002){
            self.toDateTxt.text = selectedDate
            }
        }
//        APi_AfterSelectionDate(date: self.txtAppointmentDate.text!)
        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func textFieldTouchUP(textfield: UITextField ){
        print("from date")
        self.fromDateTxt.becomeFirstResponder()
        self.fromDateTxt.tag = 1001
        textfield.resignFirstResponder()
        datePickers()
        
    }
    
    @objc func toDatetextFieldTouchUP(textfield: UITextField){
        print("to date")
        self.toDateTxt.becomeFirstResponder()
        self.toDateTxt.tag = 1002
        textfield.resignFirstResponder()
        datePickers()
        
    }
    
    //MARK: - Dictionary for Search
    fileprivate func getLoginParams() -> [String: Any] {
        let id =  UserDefaults.standard.value(forKey: "patientId") as? Int

        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let firstDate = formatter.date(from: self.fromDateTxt.text!)
        let secondDate = formatter.date(from: self.toDateTxt.text!)
            formatter.dateFormat = "yyyy-MM-dd"
        let fromDate = formatter.string(from: firstDate!)
        let toDate = formatter.string(from: secondDate!)

        let startDate = fromDate + " " + "00:00:00"
        let enddate = toDate + " " + "23:59:59"
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let resultString = inputFormatter.string(from: dt)
        let dictData: [String:Any] = ["fromDate": startDate,
                                      "patientId": String(id!),
                                      "toDate":enddate
                                     ]
        return dictData
    }
    
    func API_CheckBydateAppointment(){
        apiManager.apiPostView(serviceName: serviceURL, parameters: [:], completionHandler: {(results,error) in
            if let resultdata = results {
                print(resultdata)
                do{
                              let json = try JSONSerialization.jsonObject(with: resultdata, options: []) as? [String : Any]
                                  let status = json?["Status"] as? String
                                  if status == "Success" {
                                      MBProgressHUD.hide(for: self.view, animated: true)
                                  }
                                  print(json as Any)
                              }catch{ print("erroMsg")
                                  
                              }
            }
            
        })
    }
}
