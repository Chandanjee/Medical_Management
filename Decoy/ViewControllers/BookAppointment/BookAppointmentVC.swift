//
//  BookAppointmentVC.swift
//  Decoy
//
//  Created by MAC on 22/11/21.
//

import UIKit
import MBProgressHUD

class BookAppointmentVC: UIViewController {
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
    var selectedDateTime:String? = ""

    private let apiManager = NetworkManager()
    let serviceURL = BaseUrl.baseURL + "admin/" + "getAllCity"
//    let serviceURLWithDate = "http://103.133.215.182:8080/MobileMedicalUnit/" + "getAllCityByDate/"
    let serviceURLWithDate = BaseUrl.baseURL + "getAllCityByDate/"
    let serviceURLToken = BaseUrl.baseURL + "admin/" + "checking_token/"
    let serviceURLCreateBookVisit = BaseUrl.baseURL + "admin/" + "createVisits"
    var arrayDateList: [String] = []
    var arrayDateListSame: [String] = []
    var DuplicatarrayDateList: [String] = []

    var globalIndexValue = ""
    var globalSelectedDate = ""
    //http://103.133.215.182:8080/MobileMedicalUnit/admin/checking_token/{date}
    //http://103.133.215.182:8080/MobileMedicalUnit/getAllCityByDate/2021-11-23
    //http://103.133.215.182:8080/MobileMedicalUnit/admin/createVisits
    //    var userInfoModels  =  [ResponsesData]()
//https://2factor.in/API/R1/?module=TRANS_SMS&" + "apikey=5cdc6365-22b5-11ec-a13b-0200cd936042&" + "to="+ mobileNo1.trim()+"&" + "from=CGMSSY" + "&msg="+msg
    let sendMsgURL = "https://2factor.in/API/R1/?module=TRANS_SMS&apikey=5cdc6365-22b5-11ec-a13b-0200cd936042&"
    
    var userInfoModels : ResponsesData? = nil
    
    var appointModelArray = [ResponseAppointment]()
    var arrCityName = [String]()
    var arrCampName = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.tblHConstraint.constant = 0
//        let image = UIImage(named: "back")
//        btnBack.setImage(image?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate), for: .normal)
//        btnBack.tintColor = UIColor.white
        addArrowBtnToTextFields()
        Utility.addAllSidesShadowOnView(TopPersonalDetails)
        Utility.setViewCornerRadius(TopPersonalDetails, 8)
        Utility.addAllSidesShadowOnView(MiddleSearchView)
        Utility.setViewCornerRadius(MiddleSearchView, 8)
        tableView.register(TimeSlotViewCell.nib, forCellReuseIdentifier: TimeSlotViewCell.identifier)
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
//        tableView.reloadData()
//        tableView.setNeedsLayout()
//        tableView.layoutIfNeeded()
//        tableView.reloadData()
        
    }
    
    override func viewDidLayoutSubviews(){
//        tableView.frame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        if self.arrCityName.count > 0 {
            tableView.reloadData()
            self.tblHConstraint.constant = self.tableView.contentSize.height
        }
        
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
        let dateFormatter1 = DateFormatter()

        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "dd-MM-yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
        dateFormatter1.dateFormat = "yyyy-MM-dd HH:mm:ss"
        selectedDateTime = dateFormatter1.string(from: datePicker.date)
        if let date = sender?.date {
            print("Picked the date \(dateFormatter.string(from: date))")
            selectedDate = dateFormatter.string(from: date)
            selectedDateTime = dateFormatter1.string(from: date)

        }
    }
    
    @objc func onDoneButtonClick() {
        if selectedDate == "" {
            self.txtAppointmentDate.text = Date.getCurrentDate()
            selectedDateTime = Date.getCurrentDateWithHHmmss()

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
        self.arrCityName = []
        self.arrCampName = []
        self.arrCityName.removeAll()
        self.arrCampName.removeAll()
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat =  "dd-MM-yyyy"//"dd/MM/yyyy"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
        print(resultString)
        arrayDateList = []
        arrayDateListSame = []
//        tableView.reloadData()
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
                    let msgeg = json?["message"] as? String

                    MBProgressHUD.hide(for: self.view, animated: true)
                    
                    if status == 404 {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        Utility().addAlertView("Alert!", "Appointment should not be given for date", "ok", self)
                        return
                    }
                    
                    if status == 401 {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        Utility().addAlertView("Alert!", msgeg ?? "", "ok", self)
                        return
                    }
                    print(json as Any)
                }catch{ print("erroMsg") }
                var firstitem: Bool = false
                if  details?.response.count ?? 0 > 0{
                    self.appointModelArray = details?.response ?? []
                    var countss = 0

                    for itemss in details!.response {
                                                if firstitem == false {
                            firstitem = true
                            self.arrCityName.append("Select")
                            self.arrCampName.append("Select")
                            self.arrCityName.append(itemss.masCity.cityName.trailingSpacesTrimmed)
                            self.arrCampName.append(itemss.location.trailingSpacesTrimmed)
                            
                        }else{
                            for element in itemss.masCity.cityName{
                                if self.arrCityName.contains(itemss.masCity.cityName){
//                                    print("\(element) is Duplicate")
                                    countss = 1
                                    
                                }else{
//                                    self.arrCityName.append(element.description)
                                }
                            }
                            
                            self.arrCityName.append(itemss.masCity.cityName.trailingSpacesTrimmed)
                            
                            self.arrCampName.append(itemss.location.trailingSpacesTrimmed)
                        }
                    }
                    if (countss == 1) {
                        let dropDownBtn2 = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
                        dropDownBtn2.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal)
                        self.txtCamp.rightViewMode = UITextField.ViewMode.always
                        self.txtCamp.rightView = dropDownBtn2
                        self.txtCamp.loadDropdownData(data: self.arrCampName)
                        self.txtCamp.resignFirstResponder()
                    }
                }
                MBProgressHUD.hide(for: self.view, animated: true)
                if self.arrCityName.count > 0 {
                    self.tblHConstraint.constant = self.tableView.contentSize.height
                }
                let orderedNoDuplicates =  Array(NSOrderedSet(array: self.arrCityName).map({ $0 as! String }))

                self.txtCity.loadDropdownData(data: orderedNoDuplicates)
                if orderedNoDuplicates.count > 1 {
                    self.txtCity.text = orderedNoDuplicates[1]
                }
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
        apiManager.Api_GetWithData(serviceName: url, parameters: [:], completionHandler: {(resultDatas,error) in
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
                print(error!.localizedDescription)
                Utility().addAlertView("Alert!", "Server Error.", "ok", self)
                Loader.hideLoader(self)
            }
            

        })
    }
    
    //MARK: Select City And CAMP
    
    func textFieldEditingDidChange() {
        print("change name")
    
        if self.txtCity.text == "" {
            print("not value avail")
            return
        }
        let index =  arrCityName.firstIndex(where: { $0 == self.txtCity.text?.trimWhiteSpace }) ?? 0
        let nameID =  arrCampName[index]
        if (nameID != "" &&  nameID != "Select") {
            //            Loader.showLoader("Downloading Details...", target: self)
            self.txtCamp.text = nameID
            globalIndexValue = String(index - 1)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")!
            let date = Date()
            let df = DateFormatter()
            df.dateFormat = "HH:mm:ss"
            let dateString = df.string(from: date)
            arrayDateList = []
            arrayDateListSame = []
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
        guard let appointdate = selectedDateTime else { return}
        let inputFormatterSelected = DateFormatter()
        inputFormatterSelected.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let showDate = inputFormatterSelected.date(from: appointdate)
        let resultStringSelected = inputFormatterSelected.string(from: showDate!)
        inputFormatterSelected.dateFormat = "yyyy-MM-dd" //yyyy-MM-dd HH:mm:ss
        let resultStringSelected1 = inputFormatterSelected.string(from: showDate!)
        
        let dt = Date()
        let formatter = DateFormatter()
        let inputFormatter = DateFormatter()
        
        //        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: dt)
        let resultString1 = formatter.string(from: dt)
        let resultString12 = formatter.string(from: showDate!)

        print("cuurent date",resultString)
        print("cuurent date and time",resultString1)
        print("Selected date and time",resultString12)

        let formatter2 = DateFormatter()
        formatter2.dateFormat = "HH:mm:ss"
        
        let startDateResult = resultString + " " + startTime
        let endDateResult = resultString + " " + endTime
//        let startDateResult = resultStringSelected1 + " " + startTime
//        let endDateResult = resultStringSelected1 + " " + endTime
        let startDate = formatter.date(from: startDateResult)
        let endDate = formatter.date(from: endDateResult)
        var startTIME = ""
    
      /*
        
        if dt.compare(startDate!) == .orderedAscending {
            print("DT less than startdate")
            startTIME = startDateResult
        }else if dt.compare(endDate!) == .orderedAscending{
            print("DT less than enddate")
            startTIME = resultStringSelected

        }else if dt.compare(startDate!) == .orderedDescending{
            print("DT greater than startdate")
            startTIME = startDateResult
            Utility().addAlertView("Alert!", "Now time is not suitable", "ok", self)
            return
        }else{
                startTIME = startDateResult
                Utility().addAlertView("Alert!", "Now time is not suitable", "ok", self)
                return
        }
*/
        
        let date1 = formatter.date(from: startDateResult)
        let date2 = formatter.date(from: endDateResult)
        let interval = 60
        let stringFirst = formatter2.string(from: date1!)
        arrayDateList.append(stringFirst)
        arrayDateListSame.append(stringFirst)
        var i = 1
        while true {
            let date = date1?.addingTimeInterval(TimeInterval(i*interval*60))
            let string = formatter2.string(from: date!)
            
            if date! >= date2! {
                arrayDateList.append(string)
                arrayDateListSame.append(string)
                break;
            }
            
            i += 1
            arrayDateList.append(string)
            arrayDateListSame.append(string)
        }
//        print(arrayDateList)
        DuplicatarrayDateList = []
        if arrayDateList.count > 0 {
            guard let selctedValDate = selectedDateTime else { return}
            let inputFormatterSelected = DateFormatter()
            let inputFormatter = DateFormatter()

            let dt = Date()
            inputFormatterSelected.dateFormat = "yyyy-MM-dd HH:mm:ss"
            inputFormatterSelected.dateFormat = "HH:mm:ss"
            let resultStringSelected = inputFormatterSelected.string(from: dt)

            
            inputFormatterSelected.dateFormat = "yyyy-MM-dd"
            let currentdate = inputFormatterSelected.string(from: dt)
            inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let showDate = inputFormatter.date(from: selctedValDate)
            inputFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = inputFormatter.string(from: showDate!)
            var count = 0
            if currentdate == selectedDate {
            for(index,value) in arrayDateList.enumerated() {
                if resultStringSelected < value {
                    print( " index" ,index,value)
                    count = count + 1
                    DuplicatarrayDateList.append(value)
    //                return arrayDateList.count - 1
                }else{
                    if arrayDateList.count > 0 {
                        print( "Remove index" ,index,value)

//                        arrayDateList.remove(at: index)
                    }
                }
            }
            }else if currentdate < selectedDate{
                DuplicatarrayDateList = arrayDateList
                count = arrayDateList.count
            }
            self.tableView.reloadData()
        }
    }
    
    fileprivate func getBookParams(index:Int, bookDate:String) -> [String: Any] {
        let dt = Date()
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: dt)
        

        let datafromArray = appointModelArray[index]
        let campID = datafromArray.campID
        let departID = datafromArray.departmentID
        let mmu_ID = datafromArray.masMMU
        let lastChangeDate = mmu_ID.lastChgDate
        let date = TimeInterval(lastChangeDate).stringFromTimeInterval()
        let startDateSelect = resultString + " " + date
        let mmuid = mmu_ID.mmuID
        var id =  UserDefaults.standard.value(forKey: "patientId") as? Int
        if id == nil {
            id = userInfoModels?.patientID
        }
        let dictData: [String:Any] = ["camp_id": String(campID),
                                      "departmentID": String(departID),
                                      "lastChangeDate": startDateSelect,
                                      "mmu_id": String(mmuid),
                                      "patientId":String(id!),
                                      "status": mmu_ID.status,
                                      "visit_date": bookDate
                                     ]
        
        return dictData
    }
    
    
    //MARK: Book Time Slot
    @IBAction func SubmitTimeSlot(_ sender:Any){
        
        if globalIndexValue == "" {
            return
        }else if arrayDateList.count == 0 {
            return
        }else{
            
            let seletedTime = arrayDateList[Int(globalIndexValue)!]
            let dictData = getBookParams(index: Int(globalIndexValue)!, bookDate: globalSelectedDate)
            let mobile = userInfoModels?.mobileNumber

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
                            self.API_SendMSG(City: self.txtCity.text!, time: seletedTime, mobile: mobile!)

                            self.txtCamp.text = self.txtCamp.placeholder
                            self.txtAppointmentDate.text =  self.txtAppointmentDate.placeholder
                            self.txtCity.text = self.txtCity.placeholder
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
    
    //MARK: Send Book Slot MSG
    func API_SendMSG(City:String,time:String,mobile:String){
        let camp = appointModelArray[0].location
        let name = userInfoModels?.patientName
        var msg = "प्रिय " + name! + ", आपका ऑनलाइन अपॉइंटमेंट " + time + " पर "
        let city = City + " / " + camp + " के लिए दर्ज कर लिया गया है। \n" + "सादर, \n" + "CGMSSY"
        let fullSentence = msg + city
        print("msg register",fullSentence)
        let urlEndPoint = "to=" + mobile + "&" + "from=CGMSSY" + "&msg=" + fullSentence
        let newURL = sendMsgURL + urlEndPoint
        print("New Send MSg url",newURL)
        apiManager.Api_GetWithData(serviceName: newURL, parameters: [:], completionHandler: {(result,error) in
            if let resultData = result {
                do{
                    let json = try JSONSerialization.jsonObject(with: resultData, options: []) as? [String : Any]
                    let status = json?["status"] as? NSNumber
                    let response = json?["response"] as? [String:Any]
                    let msg = response?["message"] as? String
                    print("Booking msg status",msg as Any)
                }catch{ print("erroMsg") }
            }
        })

    }
}


extension BookAppointmentVC:UITextFieldDelegate{
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

extension BookAppointmentVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*
        guard let selctedValDate = selectedDateTime else { return 0}
        let inputFormatterSelected = DateFormatter()
        let inputFormatter = DateFormatter()

        let dt = Date()
        inputFormatterSelected.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatterSelected.dateFormat = "HH:mm:ss"
        let resultStringSelected = inputFormatterSelected.string(from: dt)

        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatterSelected.dateFormat = "yyyy-MM-dd"
        let currentdate = inputFormatterSelected.string(from: dt)
        print(selectedDateTime)
        let showDate = inputFormatterSelected.date(from: selctedValDate)
        let selectedDate = inputFormatterSelected.string(from: showDate!)
        var count = 0
        if currentdate == selectedDate {
        for(index,value) in arrayDateList.enumerated() {
            if resultStringSelected < value {
                print( " index" ,index,value)
                count = count + 1
                DuplicatarrayDateList.append(value)
//                return arrayDateList.count - 1
            }else{
                print( "Remove index" ,index,value)

                arrayDateList.remove(at: index)
            }
        }
        }else if currentdate < selectedDate{
            DuplicatarrayDateList = arrayDateList
            count = arrayDateList.count
        }
        if count > 1 {
           return count - 1
        }else{
        return count
        }*/
        
        return DuplicatarrayDateList.count - 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimeSlotViewCell", for: indexPath) as? TimeSlotViewCell else {
            fatalError("can't dequeue CustomCell")
        }
     
        let inputFormatterSelected = DateFormatter()
        let dt = Date()
        inputFormatterSelected.dateFormat = "HH:mm:ss"
        inputFormatterSelected.dateFormat = "HH:mm:ss"

        let resultStringSelected = inputFormatterSelected.string(from: dt)
       
//        for (index,items) in DuplicatarrayDateList.enumerated() {
//            let secondTime = DuplicatarrayDateList[index+1]
//            if resultStringSelected < items {
//                let FirstTime = DuplicatarrayDateList[index]
//                print(FirstTime, "," ,secondTime)
//                cell.loadData(startTime: FirstTime, endTime: secondTime)
//
//            }
//        }
        let FirstTime = DuplicatarrayDateList[indexPath.row]
        let secondTime = DuplicatarrayDateList[indexPath.row+1]
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
//        globalIndexValue = String(indexPath.row)
        globalSelectedDate = startDateSelect
        API_GetTokenonDate(date: startDateSelect, handlerValue: { [weak self](valuess)in
        print("return message of appointment",valuess)
            cell?.lblAppointmentCount.text! = valuess
        }
)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        self.tblHConstraint.constant = self.tableView.contentSize.height

//        self.tableView.contentSizeHeight = 55 //CGFloat(cell.contentView.frame.height * CGFloat(indexPath.row))
    }
}


extension TimeInterval{

        func stringFromTimeInterval() -> String {

            let time = NSInteger(self)

            let ms = Int((self.truncatingRemainder(dividingBy: 1)) * 1000)
            let seconds = time % 60
            let minutes = (time / 60) % 60
            let hours = (time / 3600)

            return String(format: "%0.2d:%0.2d:%0.2d.%0.3d",hours,minutes,seconds,ms)

        }
    }
