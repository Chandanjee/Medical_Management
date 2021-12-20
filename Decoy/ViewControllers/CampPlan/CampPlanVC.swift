//
//  CampPlanVC.swift
//  Decoy
//
//  Created by MAC on 21/11/21.
//

import UIKit
import MBProgressHUD
import CoreLocation

class CampPlanVC: UIViewController {
    @IBOutlet weak var toDate:UITextField!
    @IBOutlet weak var fromDate:UITextField!
    @IBOutlet weak var cityTxt:UITextField!
    @IBOutlet weak var btnSearch:UIButton!
    @IBOutlet weak var backViewTops:UIView!
    @IBOutlet weak var tableViews:UITableView!

    var arrCityName = [String]()
    var arrCityID = [String]()
    var arrCityCode = [String]()

    var datePicker = UIDatePicker()
    var toolbar = UIToolbar()
    var selectedDate = ""
    var latCordinate:Double = 0.0
    var longCordinate:Double = 0.0

    var selectedTextField = 0
    var userInfoModel = [CampResponse]()
    let locationService = CoreLocationManager()

    private let apiManager = NetworkManager()
//    let serviceURL = "http://103.133.215.182:8080/MobileMedicalUnit/getAllCity" //BaseUrl.baseURL + "getAllCity" // http://103.133.215.182:8080/MobileMedicalUnit/getAllCity
    let serviceURL = BaseUrl.baseURL + "getAllCity" //
    let serviceUrlCamp = BaseUrl.baseURL + "admin/" + "getMasCampPlan"
    override func viewDidLoad() {
        super.viewDidLoad()
        let dropDownBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        dropDownBtn.setBackgroundImage(UIImage(named: "fill_downArrow_small.png"), for: UIControl.State.normal) //  downArrow_black arrowtriangle.down.fill, IQButtonBarArrowDown
        self.cityTxt.rightViewMode = UITextField.ViewMode.always
        self.cityTxt.rightView = dropDownBtn
        
        Utility.addAllSidesShadowOnView(backViewTops)
        Utility.setViewCornerRadius(backViewTops, 8)
        tableViews.register(CamPlanCell.nib, forCellReuseIdentifier: CamPlanCell.identifier)
        API_City()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        didTapAllow()
        getCurrentLocationCoordinatesResult()
        //        txtAppointmentDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.touchDown)
        fromDate.addTarget(self, action: #selector(textFieldTouchUP), for: UIControl.Event.editingDidBegin)
        toDate.addTarget(self, action: #selector(toDatetextFieldTouchUP), for: UIControl.Event.editingDidBegin)
        tableViews.reloadData()
        tableViews.setNeedsLayout()
        tableViews.layoutIfNeeded()
        tableViews.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    @IBAction func tapToSearch(_ sender:Any){
        fetchDataCampPlan()
    }
    @IBAction func tapToBack(_ sender:Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Location Manager
    
    func didTapAllow() {
         locationService.requestLocationAuthorization()
     }
    
    func getCurrentLocationCoordinates(){
      locationService.newLocation = {result in
        switch result {
         case .success(let location):
         print(location.coordinate.latitude, location.coordinate.longitude)
         case .failure(let error):
         assertionFailure("Error getting the users location \(error)")
      }
     }
   }
    
    func getCurrentLocationCoordinatesResult() {
        locationService.newLocation = { result in
            switch result {
            case .success(let location):
                print(location.coordinate.latitude, location.coordinate.longitude)
                self.latCordinate = location.coordinate.latitude
                self.longCordinate = location.coordinate.longitude
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                    if error != nil {
                        print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                        return
                    }
                    if (placemarks?.count)! > 0 {
                        print("placemarks", placemarks!)
                        let pmark = placemarks?[0]
                        print(pmark)
//                        self.displayLocationInfo(pmark)
                    } else {
                        print("Problem with the data received from geocoder")
                    }
                })
            case .failure(let error):
                assertionFailure("Error getting the users location \(error)")
            }
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
//        if status == true {
//            datePicker.minimumDate = prevDate
//        }
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
            if (selectedTextField == 1001) {
                print("fromDate")
                self.fromDate.text = Date.getCurrentDate()
            }else if (selectedTextField == 1002){
                print("toDate")

            self.toDate.text = Date.getCurrentDate()
            }
        }else{
            if (selectedTextField == 1001) {
                print("fromDate=1")

                self.fromDate.text = selectedDate
            }else if (selectedTextField == 1002){
                print("toDate=2")
            self.toDate.text = selectedDate
            }
        }
//        APi_AfterSelectionDate(date: self.txtAppointmentDate.text!)
        toolbar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
    
    @objc func textFieldTouchUP(textfield: UITextField ){
        print("from date")
        self.fromDate.becomeFirstResponder()
        selectedTextField = 1001
        textfield.resignFirstResponder()
        datePickers(status: true)
        
    }
    
    //MARK: - To Date
    @objc func toDatetextFieldTouchUP(textfield: UITextField){
        print("to date")
        self.toDate.becomeFirstResponder()
        selectedTextField = 1002
        textfield.resignFirstResponder()
        datePickers(status: false)
        
    }
    
    func API_City(){
        apiManager.Api_GetWithData(serviceName: serviceURL, parameters: [:], completionHandler: {result,error in
            if let errors = error {
                print(errors.localizedDescription)
            }else{
                print(result as Any)
                if let response = result {
                    do{
                        let json = try JSONSerialization.jsonObject(with: response, options: []) as? [String : Any]
                        let status = json?["Status"] as? NSNumber
                        let msg = json?["Status"] as? String
                        let responseArray = json?["response"] as? [[String:Any]] ?? []
                        var firstitem: Bool = false
                        
                        if status == 200 {
                            MBProgressHUD.hide(for: self.view, animated: true)
                        }
                        for jsondata in responseArray {
                            print(jsondata)
                            if firstitem == false {
                                firstitem = true
                                self.arrCityName.append("Select")
                                self.arrCityCode.append("Select")
                                self.arrCityID.append("Select")
                                let id = jsondata["cityId"] as? Int
                                self.arrCityName.append((jsondata["cityName"] as? String)!)
                                self.arrCityCode.append((jsondata["cityCode"] as? String)!)
                                self.arrCityID.append(String(id!))
                            }else{
                                let id = jsondata["cityId"] as? Int
                                self.arrCityName.append((jsondata["cityName"] as? String)!)
                                self.arrCityCode.append((jsondata["cityCode"] as? String)!)
                                self.arrCityID.append(String(id!))
                            }
                        }
                    }catch{ print("erroMsg") }
                }
                if self.arrCityName.count > 0 {
                    self.cityTxt.loadDropdownData(data: self.arrCityName)
                }
            }
        })
        
    }
    
    
    //MARK: - Dictionary for Search
    fileprivate func getSearchParams() -> [String: Any] {
        let id =  UserDefaults.standard.value(forKey: "patientId") as? Int
       
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let firstDate = formatter.date(from: self.fromDate.text!)
        let secondDate = formatter.date(from: self.toDate.text!)
            formatter.dateFormat = "yyyy-MM-dd"
        let fromDate = formatter.string(from: firstDate!)
        let toDate = formatter.string(from: secondDate!)
        let index =  arrCityName.firstIndex(where: { $0 == self.cityTxt.text }) ?? 0
        let nameID =  arrCityID[index]

        let startDate = fromDate + " " + "00:00:00"
        let enddate = toDate + " " + "23:59:59"
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let resultString = inputFormatter.string(from: dt)
        let dictData: [String:Any] = ["fromDate":startDate, //"2021-10-28 00:00:00", //startDate,
                                      "cityID":nameID,
                                      "toDate":enddate //"2021-11-30 23:59:59"//enddate
                                     ]
        return dictData
    }
    
    func fetchDataCampPlan(){
        if self.fromDate.text == "" || self.fromDate.text == nil || self.toDate.text == nil || self.toDate.text == ""{
            Utility().addAlertView("Alert!",  "Select both date", "ok", self)
            return
        }
        if self.cityTxt.text == "Select" || self.cityTxt.text == "" || self.cityTxt.text == nil {
            Utility().addAlertView("Alert!",  "Select your city", "ok", self)
            return
        }
        let dataDic = getSearchParams()
        MBProgressHUD.showAdded(to: self.view, animated: true)

        apiManager.apiPostView(serviceName: serviceUrlCamp, parameters: dataDic, completionHandler: {(resultData,error) in
            if let response = resultData {
                print(response)
                let details = try? newJSONDecoder().decode(CampPlanResponse.self, from: response)
                let dataResult = details?.response
                MBProgressHUD.hide(for: self.view, animated: true)

                if dataResult?.count ?? 0 > 0{
                    for items in details!.response {
                        self.userInfoModel.append(items)
                    }
                    print("Count Camp plan ",self.userInfoModel.count)
                    self.tableViews.reloadData()
                }else{
                    Utility().addAlertView("Alert!",  "No data found.", "ok", self)

                }
            }else{
                MBProgressHUD.hide(for: self.view, animated: true)
                Utility().addAlertView("Alert!",  error!.localizedDescription, "ok", self)

            }
        })
    }
    
}
extension CampPlanVC:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userInfoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CamPlanCell", for: indexPath) as? CamPlanCell else {
            fatalError("can't dequeue CustomCell")
        }
//        cell.cellViewModel = userInfoModel[indexPath.row]
        cell.loadCellDataOne(lat: latCordinate, long: longCordinate, cellViewModel: userInfoModel[indexPath.row])
        return cell
    }
}
