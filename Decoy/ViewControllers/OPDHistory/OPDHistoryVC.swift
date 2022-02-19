//
//  OPDHistoryVC.swift
//  Decoy
//
//  Created by MAC on 01/12/21.
//

import UIKit
import MBProgressHUD


class OPDHistoryVC: UIViewController,OPDButtonCellDelegate {
    
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var fromDateTxt:UITextField!
    @IBOutlet weak var toDateTxt:UITextField!
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var btnBack:UIButton!
    @IBOutlet weak var backViewTop:UIView!
    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedDate = ""
    var selectedTextField = 0

    private let apiManager = NetworkManager()
    var userHistoryModel = [OPDResponse]()
    var userInfoOPDModels : ResponsesData? = nil

    let serviceURL = BaseUrl.baseURL + "admin/" + "fetchCompleteOpdData"
    let serviceURLDelete = BaseUrl.baseURL + "admin/" + "cancelVisit"
let basePDFUrl = "http://103.133.215.182:8080/MMUWeb/report/"
    override func viewDidLoad() {
        super.viewDidLoad()
//        let image = UIImage(named: "back")
//        btnBack.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
//        btnBack.tintColor = UIColor.white
        Utility.addAllSidesShadowOnView(backViewTop)
        Utility.setViewCornerRadius(backViewTop, 10)
        if #available(iOS 13.0, *) {
            let image = UIImage(named: "imageName")?.withTintColor(.white, renderingMode: .alwaysTemplate)
        } else {
            // Fallback on earlier versions
        }
        tableView.register(OPDTableCell.nib, forCellReuseIdentifier: OPDTableCell.identifier)
        defaultDate()
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
        self.API_CheckBydateAppointment()
        
    }
    
    @IBAction func tapToBack(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Delegate Method
    func didOPDPressButton(tag: Int,Status:Bool) {
//        let visitID = self.userHistoryModel[tag]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let v1 = storyboard.instantiateViewController(withIdentifier:"PDFViewController") as? PDFViewController
        if Status == true {
            let visitID = self.userHistoryModel[tag]
            let id = visitID.visit.visitID
            let urlStr = basePDFUrl + "referReportSlip" + "?visit_id=\(id)"
            v1?.titleData = "Refer Report"
            v1?.pdfURL = URL(string: urlStr)
                self.navigationController?.pushViewController(v1!, animated: true)
        }else{
            let visitID = self.userHistoryModel[tag]
            let id = visitID.visit.visitID
            let urlStr = basePDFUrl + "printCaseSheet" + "?visit_id=\(id)"
            v1?.titleData = "Slip"
            v1?.pdfURL = URL(string: urlStr)
                self.navigationController?.pushViewController(v1!, animated: true)
        }
    }
    
    //MARK: Date Picker

    func datePickers(status:Bool){
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white
        
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
//        datePicker.minimumDate = Date()
        
        let currentDate = NSDate()

        let prevDate = Calendar.current.date(byAdding: .month, value: -1, to: currentDate as Date)
        if status == true {
//            datePicker.minimumDate = prevDate
        }
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
    
    func defaultDate(){
        let dt = Date()
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"
        let resultString = inputFormatter.string(from: dt)
        self.toDateTxt.text = resultString
//        self.fromDateTxt.text = resultString
        let previousMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let resultString1 = inputFormatter.string(from: previousMonth!)

        self.fromDateTxt.text = resultString1
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
            if (selectedTextField == 1001) {
                print("fromDate")
                self.fromDateTxt.text = Date.getCurrentDate()
            }else if (selectedTextField == 1002){
                print("toDate")

            self.toDateTxt.text = Date.getCurrentDate()
            }
        }else{
            if (selectedTextField == 1001) {
                print("fromDate=1")

                self.fromDateTxt.text = selectedDate
            }else if (selectedTextField == 1002){
                print("toDate=2")
            self.toDateTxt.text = selectedDate
            }
        }
//        APi_AfterSelectionDate(date: self.txtAppointmentDate.text!)
        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    //MARK: - From Date
    @objc func textFieldTouchUP(textfield: UITextField ){
        print("from date")
        self.fromDateTxt.becomeFirstResponder()
        selectedTextField = 1001
        textfield.resignFirstResponder()
        datePickers(status: true)
        
    }
    
    //MARK: - To Date
    @objc func toDatetextFieldTouchUP(textfield: UITextField){
        print("to date")
        self.toDateTxt.becomeFirstResponder()
        selectedTextField = 1002
        textfield.resignFirstResponder()
        datePickers(status: false)
        
    }
    
    //MARK: - Dictionary for Search
    fileprivate func getSearchParams() -> [String: Any] {
        let id =  UserDefaults.standard.value(forKey: "patientId") as? Int
        let patID = userInfoOPDModels?.patientID
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
        let dictData: [String:Any] = ["fromDate":startDate, //"2021-10-28 00:00:00", //startDate,
                                      "patientId":String(patID!),
                                      "toDate":enddate //"2021-11-30 23:59:59"//enddate
                                     ]
        return dictData
    }
    
    
    func API_CheckBydateAppointment(){
        let dataDic = getSearchParams()
        print("Search request data",serviceURL ,dataDic)
        apiManager.apiPostView(serviceName: serviceURL, parameters: dataDic, completionHandler: {(results,error) in
            if let resultdata = results {
                print(resultdata)
                let details = try? newJSONDecoder().decode(OPDResponseModel.self, from: resultdata)
                //                print(details?.response[0].location)
                //                print(details?.response[0].landMark)
                print("Total array iof appointment ==",details?.response.count as Any, self.userHistoryModel)
                self.userHistoryModel = details?.response ?? []
                do{
                              let json = try JSONSerialization.jsonObject(with: resultdata, options: []) as? [String : Any]
                                  let status = json?["status"] as? NSNumber
                    let msg = json?["message"] as? String

                                  if status == 200 {
                                      MBProgressHUD.hide(for: self.view, animated: true)
                                      self.tableView.reloadData()
                                  }
                    if status == 401 {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        Utility().addAlertView("Alert!", msg ?? "", "ok", self)
                        return
                    }
//                    print(json?["response"].count as Any)
                              }catch{ print("erroMsg")
                                  
                              }
            }
            
        })
    }
    
    @IBAction func tapToSearch(_ sender:Any){
        self.API_CheckBydateAppointment()
    }
    
    func API_DeleteAppointment(index:Int){
//        {"visitID":"406","patientId":"204"}
        let itemData = userHistoryModel[index]
//        let Visit = itemData.visit.visitID
//        let Patient = itemData.visit.patientID
        let requestData : [String:Any] = ["visitID":"Visit",
                                          "patientId":"Patient"]
        print("Delete Request data and url",serviceURLDelete,requestData)
        apiManager.Api_GetWithData(serviceName: serviceURLDelete, parameters: requestData, completionHandler: {
            (resultData,error) in
            print(resultData)
            if let responsedata = resultData {
            do{
                let json = try JSONSerialization.jsonObject(with: responsedata, options: []) as? [String : Any]
                let status = json?["status"] as? NSNumber
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if status == 404 {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    Utility().addAlertView("Alert!", "Appointment should not be given for date", "ok", self)
                    return
                }
                
                print(json as Any)
            }catch{ print("erroMsg") }
            }
        })

    }
}

extension OPDHistoryVC:UITextViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHistoryModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "OPDTableCell", for: indexPath) as? OPDTableCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.btnSLip.tag = indexPath.row
        cell.btnReferral.tag = indexPath.row
        cell.cellDelegate = self
        cell.cellViewModel = userHistoryModel[indexPath.row]

        return cell
    }
    
    
}
