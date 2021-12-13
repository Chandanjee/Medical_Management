//
//  RescheduleVC.swift
//  Decoy
//
//  Created by MAC on 06/12/21.
//

import UIKit
import MBProgressHUD

class RescheduleVC: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var lblFullName:UILabel!
    @IBOutlet weak var lblGender:UILabel!
    @IBOutlet weak var lblAge:UILabel!
    @IBOutlet weak var TopPersonalDetails:UIView!
    @IBOutlet weak var MiddleSearchView:UIView!
    @IBOutlet weak var txtAppointmentDate:UITextField!
    @IBOutlet weak var txtCity:UITextField!
    @IBOutlet weak var txtCamp:UITextField!
    @IBOutlet weak var btnSubmit:UIButton!
    @IBOutlet weak var btnBack:UIButton!
    
    @IBOutlet weak var tblHConstraint: NSLayoutConstraint!

    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedDate = ""
    private let apiManager = NetworkManager()
    let serviceURL = BaseUrl.baseURL + "getAllCity"
    let serviceURLWithDate = "http://103.133.215.182:8080/MobileMedicalUnit/" + "getAllCityByDate/"
    let serviceURLToken = BaseUrl.baseURL + "checking_token/"
    let serviceURLCreateBookVisit = BaseUrl.baseURL + "createVisits"
    var arrayDateList: [String] = []
    var globalIndexValue = ""
    var globalSelectedDate = ""
    //http://103.133.215.182:8080/MobileMedicalUnit/admin/checking_token/{date}
    //http://103.133.215.182:8080/MobileMedicalUnit/getAllCityByDate/2021-11-23
    //http://103.133.215.182:8080/MobileMedicalUnit/admin/createVisits
    //    var userInfoModels  =  [ResponsesData]()
    
    var userInfoModels : ResponsesData? = nil
    
    var appointModelArray = [ResponseAppointment]()
    var userResultUpdateModel: HistoryResponse? = nil

    var arrCityName = [String]()
    var arrCampName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tblHConstraint.constant = 0
        addArrowBtnToTextFields()
        Utility.addAllSidesShadowOnView(TopPersonalDetails)
        Utility.setViewCornerRadius(TopPersonalDetails, 8)
        Utility.addAllSidesShadowOnView(MiddleSearchView)
        Utility.setViewCornerRadius(MiddleSearchView, 8)
        tableView.register(TimeSlotViewCell.nib, forCellReuseIdentifier: TimeSlotViewCell.identifier)
        let images = UIImage(named: "back")
        btnBack.setImage(images?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
        btnBack.tintColor = UIColor.white
        self.API_City()
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
        
        //        txtAppointmentDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.touchDown)
        txtAppointmentDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.editingDidBegin)
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.reloadData()
        let name = userResultUpdateModel?.patient.patientName
        self.lblFullName.text = name
        let gend = userResultUpdateModel?.patient.administrativeSexID.administrativeSexName
        var gender = ""
//        switch gend {
//        case .f:
//            gender = "Female"
//        case .m:
//            gender = "Male"
//        case .none:
//            gender = ""
//        }
        lblGender.text = gend
        let age = (userResultUpdateModel?.patient.age.description)! + " years"
        lblAge.text = age
    }
    
    override func viewDidLayoutSubviews(){
//        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        if self.arrCityName.count > 0 {
            self.tblHConstraint.constant = self.tableView.contentSize.height
        }
         tableView.reloadData()
        
    }
    
    @objc func textFieldTouchUP(textfield: UITextField ){
        print("using date")
        self.txtAppointmentDate.becomeFirstResponder()
        textfield.resignFirstResponder()
        datePickers()
        
    }
    
    // MARK: - Navigation
    @IBAction func tapToBackInfo(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Add Arrow on TextField
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
        //        txtCamp.rightViewMode = UITextField.ViewMode.always
        //        txtCamp.rightView = dropDownBtn2
        
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
            self.txtAppointmentDate.text = Date.getCurrentDate()
        }else{
            self.txtAppointmentDate.text = selectedDate
        }
        APi_AfterSelectionDate(date: self.txtAppointmentDate.text!)
        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    func API_City(){
        NetworkManager.apiGet(serviceName: serviceURL, parameters: [:], completionHandler: {result,error in
            print(result as Any)
        })
        
        //        apiManager.apiPostView(serviceName: serviceURL, parameters: [:], completionHandler: {result,error in
        //            if let response = result {
        //                do{
        //                let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
        //                    let status = json?["Status"] as? String
        //                    if status == "Success" {
        //                        MBProgressHUD.hide(for: self.view, animated: true)
        //                    }
        //                    print(json as Any)
        //                }catch{ print("erroMsg") }
        //            }
        //        })
    }
    
    //MARK: API After Date Selection
    func APi_AfterSelectionDate(date:String){
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat =  "dd-MM-yyyy"//"dd/MM/yyyy"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        
        let urlWithDate = serviceURLWithDate + resultString //2021-11-23
        //        let url = urlWithDate + newdate
        MBProgressHUD.showAdded(to: self.view, animated: true)
        print("Appointment date url",urlWithDate)
        apiManager.Api_GetWithData(serviceName: urlWithDate, parameters: [:], completionHandler: {(result,error) in
            if let responsedata = result {
                print(responsedata)
                let details = try? newJSONDecoder().decode(AppointmentResponseModel.self, from: responsedata)
                //                print(details?.response[0].location)
                //                print(details?.response[0].landMark)
                print("Total array iof appointment ==",details?.response.count as Any, totalAppointmentCity())
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
                var firstitem: Bool = false
                if  details?.response.count ?? 0 > 0{
                    self.appointModelArray = details?.response ?? []
                    for itemss in details!.response {
                        if firstitem == false {
                            firstitem = true
                            self.arrCityName.append("Select")
                            self.arrCampName.append("Select")
                            self.arrCityName.append(itemss.location.trailingSpacesTrimmed)
                            self.arrCampName.append(itemss.landMark.trailingSpacesTrimmed)
                            
                        }else{
                            self.arrCityName.append(itemss.location.trailingSpacesTrimmed)
                            self.arrCampName.append(itemss.landMark.trailingSpacesTrimmed)
                        }
                    }
                }
                MBProgressHUD.hide(for: self.view, animated: true)
                if self.arrCityName.count > 0 {
                    self.tblHConstraint.constant = self.tableView.contentSize.height
                }
                self.txtCity.loadDropdownData(data: self.arrCityName)
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                Utility().addAlertView("Alert!", "Server is not responding", "ok", self)
            }
        })
    }
    
    //MARK: API Token
    func API_GetTokenonDate(date:String,handlerValue: @escaping ((String)->Void)){
        let url = serviceURLToken + date
        var allowedQueryParamAndKey = NSCharacterSet.urlQueryAllowed
        allowedQueryParamAndKey.remove(charactersIn: " ")
        let  urlEncode = url.addingPercentEncoding(withAllowedCharacters: allowedQueryParamAndKey)
        print("token api", urlEncode as Any)
        
//        Loader.showLoader("Wait checking your slot...", target: self)
        var ResponseMSG:String? = ""
        apiManager.Api_GetWithData(serviceName: urlEncode!, parameters: [:], completionHandler: {(resultDatas,error) in
            if let responsedata = resultDatas {
                do{
                    let json = try JSONSerialization.jsonObject(with: responsedata, options: []) as? [String : Any]
                    let status = json?["status"] as? NSNumber
                    let message = json?["message"] as? String
                    let responses = json?["response"] as? [String:Any]
                    if message == "succss" {

                        if let person = responses {
                           print(person["name"] as! String)
                            ResponseMSG = person["name"] as? String ?? ""
                            handlerValue(ResponseMSG!)
                        }
                    }else{
                        handlerValue(message!)
//                        Utility().addAlertView("Alert!", message!, "ok", self)
                    }
                    Loader.hideLoader(self)
                    
                    if status == 404 {
                        Utility().addAlertView("Alert!", "Appointment should not be given for date", "ok", self)
                        return
                    }
                    
                    print(json as Any)
                }catch{ print("erroMsg") }
            }else{
                Loader.hideLoader(self)
            }
            

        })
    }
    
    //MARK: Select City And CAMP
    
    func textFieldEditingDidChange() {
        print("change name")
        let index =  arrCityName.firstIndex(where: { $0 == self.txtCity.text?.trimWhiteSpace }) ?? 0
        let nameID =  arrCampName[index]
        if (nameID != "" &&  nameID != "Select") {
            //            Loader.showLoader("Downloading Details...", target: self)
            self.txtCamp.text = nameID
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
            arrayDateList = []
            let startTimeStr = appointModelArray[index - 1].startTime
            let endTimeStr = appointModelArray[index - 1].endTime
            print("Start and end Time == ",startTimeStr,endTimeStr)
            setTimeArray(startTime: startTimeStr, endTime: endTimeStr)
            //            let dateENDFromStr = dateFormatter.date(from: endTimeStr) ?? nil
            //            let dateStartFromStr = dateFormatter.date(from: startTimeStr) ?? nil
            //
            //            let difference = Calendar.current.dateComponents([.hour, .minute, .second], from:dateStartFromStr! , to: dateENDFromStr! )
            ////            let formattedString = String(format: "%02ld%02ld", difference.hour!, difference.minute!,difference.second!)
            //            let formattedString = String(format: "%02ld", difference.hour!, difference.minute!,difference.second!)
            //
            //            print(formattedString)
            //            let intte = Int(formattedString)
            //            for i in 1...intte! {
            //                print(i)
            //            }
            
        }
    }
    
    //MARK: Create Slote Wise Time
    func setTimeArray(startTime:String, endTime:String){
        
        let dt = Date()
        let formatter = DateFormatter()
        let inputFormatter = DateFormatter()
        
        //        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: dt)
        print("cuurent date",resultString)
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "HH:mm:ss"
        
        let startDateResult = resultString + " " + startTime
        let endDateResult = resultString + " " + endTime
        
        let date1 = formatter.date(from: startDateResult)
        let date2 = formatter.date(from: endDateResult)
        let interval = 60
        let stringFirst = formatter2.string(from: date1!)
        arrayDateList.append(stringFirst)
        var i = 1
        while true {
            let date = date1?.addingTimeInterval(TimeInterval(i*interval*60))
            let string = formatter2.string(from: date!)
            
            if date! >= date2! {
                arrayDateList.append(string)
                break;
            }
            
            i += 1
            arrayDateList.append(string)
        }
        print(arrayDateList)
        self.tableView.reloadData()
    }
    
    fileprivate func getBookParams(index:Int, bookDate:String) -> [String: Any] {
        let dt = Date()
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: dt)
        

//let datafromArray = appointModelArray[index]
        let campID = userResultUpdateModel?.masCamp.campID
        let departID = userResultUpdateModel?.masDepartment.departmentID
        let mmu_ID = userResultUpdateModel?.masCamp.masMMU
        let lastChangeDate = mmu_ID?.lastChgDate
        let date = TimeInterval(lastChangeDate!).stringFromTimeInterval()
        let startDateSelect = resultString + " " + date
        let mmuid = mmu_ID?.mmuID
        let stat = mmu_ID?.status.rawValue
       let id =  UserDefaults.standard.value(forKey: "patientId") as? Int
        /*
         {"camp_id":"435","departmentID":"2","lastChangeDate":"2021-12-01 17:07:11.783","mmu_id":"1","patientId":"204","status":"N","visitId":"411","visit_date":"2021-12-02 09:30:00.0"}
         */
        
        let dictData: [String:Any] = ["camp_id": String(campID!),
                                      "departmentID": String(departID!),
                                      "lastChangeDate": startDateSelect,
                                      "mmu_id": String(mmuid!),
                                      "patientId":String(id!),
                                      "status": String(stat!),
                                      "visitId":String((userResultUpdateModel?.visit.visitID)!),
                                      "visit_date": bookDate
                                     ]
        
        return dictData
    }
    
    @IBAction func SubmitTimeSlot(_ sender:Any){
        
        if globalIndexValue == "" {
            return
        }else{
            
            let dictData = getBookParams(index: Int(globalIndexValue)!, bookDate: globalSelectedDate)
            print("createBook appoint url and Data ",serviceURLCreateBookVisit , dictData)
            apiManager.apiPostView(serviceName: serviceURLCreateBookVisit, parameters: dictData, completionHandler: {(resultData,error )in
                if let resuts = resultData {
                    print(resuts)
                    do{
                        let json = try JSONSerialization.jsonObject(with: resuts, options: []) as? [String : Any]
                        let status = json?["status"] as? NSNumber
                        let response = json?["response"] as? [String:Any]
                        let msg = response?["message"] as? String
                        print("Booking msg status",msg as Any)
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        if status == 404 {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            Utility().addAlertView("Alert!", "Appointment should not be given for date", "ok", self)
                            return
                        }
                        if status == 208 {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            Utility().addAlertView("Alert!", "Appointment is already booked for this date", "ok", self)
                            return
                        }
                        if status == 200 {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            Utility().addAlertView("Alert!", "Visit create successfully", "ok", self)
                            return
                        }
                        
                        print(json as Any)
                    }catch{ print("erroMsg") }
                }else{
                    if let errors = error {
                        print(errors.localizedDescription)
                        Utility().addAlertView("Alert!", errors.localizedDescription, "ok", self)
                    }
                }
            })
        }
        
        
        //        Loader.showLoader("Wait checking your slot...", target: self)
        
//        {"camp_id":"367","departmentID":"2","lastChangeDate":"2021-11-28 15:43:48.685","mmu_id":"59","patientId":"204","status":"N","visit_date":"2021-11-29 08:30:00.0"}
        
        

    }
}
extension RescheduleVC:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextField did end editing method called  = \(textField.text!)")
        if (textField.tag == 111 || textField == txtCity){
            textFieldEditingDidChange()
        }
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //        print("TextField should begin editing method called")
        return true;
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        //        print("TextField should clear method called")
        return true;
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //        print("TextField should end editing method called")
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //        print("While entering the characters this method gets called")
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        print("TextField should return method called")
        textField.resignFirstResponder();
        return true;
    }
    
    
}
extension RescheduleVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayDateList.count-1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotViewCell", for: indexPath) as? TimeSlotViewCell else {
            fatalError("can't dequeue CustomCell")
        }
        let FirstTime = arrayDateList[indexPath.row]
        let secondTime = arrayDateList[indexPath.row+1]
        cell.loadData(startTime: FirstTime, endTime: secondTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dt = Date()
        let inputFormatter = DateFormatter()
        
        //        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: dt)
        print("cuurent date",resultString)
        let startTime = arrayDateList[indexPath.row]
        let startDateSelect = resultString + " " + startTime
        print("cuurent time Select",startDateSelect)
        let cell = tableView.cellForRow(at: indexPath) as? TimeSlotViewCell
        globalIndexValue = String(indexPath.row)
        globalSelectedDate = startDateSelect
        API_GetTokenonDate(date: startDateSelect, handlerValue: { [weak self](valuess)in
        print("return message of appointment",valuess)
            cell?.lblAppointmentCount.text! = valuess
            tableView.reloadData()
        }
)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.tblHConstraint.constant = self.tableView.contentSize.height

//        self.tableView.contentSizeHeight = 55 //CGFloat(cell.contentView.frame.height * CGFloat(indexPath.row))
    }
}
