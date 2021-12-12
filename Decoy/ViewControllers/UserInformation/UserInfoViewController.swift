//
//  UserInfoViewController.swift
//  Decoy
//
//  Created by MAC on 25/10/21.
//

import UIKit
import Foundation
import MBProgressHUD

class UserInfoViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnBack:UIButton!
    private let apiManager = NetworkManager()
var targetOption = ""
    let serviceUrl = BaseUrl.baseURL + "getPatientList"
    var userInfoModel = [ResponsesData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserInfoCell.nib, forCellReuseIdentifier: UserInfoCell.identifier)
        // Do any additional setup after loading the view.
        self.Data_ListPatient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        tableView.reloadData()
        tableView.setNeedsLayout()
        tableView.layoutIfNeeded()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    @IBAction func tapToBack(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
   
    
    func Data_ListPatient(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
      let  mobile =  UserDefaults.standard.value(forKey: "LoginMobilenum") as? String
        API_getViewAllTickets(json: PatientRequestModel.init(username: mobile!), data: {
            
            responseData,status  in
            
            print(responseData?.response.count as Any)
//                self?.userResultModel = response?.result ?? []
            let dataResult = responseData?.response
            if dataResult?.count ?? 0 > 0{
                self.userInfoModel = dataResult ?? []
                UserDefaults.standard.set(self.userInfoModel[0].patientID, forKey: "patientId")
                UserDefaults.standard.set(self.userInfoModel[0].patientName, forKey: "Username")
                UserDefaults.standard.set(self.userInfoModel[0].mobileNumber, forKey: "LoginMobilenum")
                UserDefaults.standard.set(self.userInfoModel[0].loginPwd, forKey: "LoginPassword")


            }else{
                self.userInfoModel =  []
            }
            MBProgressHUD.hide(for: (self.view)!, animated: true)

            self.tableView.reloadData()
        })
    }

    func API_getViewAllTickets(json:PatientRequestModel, data:@escaping (_ result:PatientListJSONModel?,_ resultBool: Bool) -> ()){
        let jsons =  PatientRequestModel.encode(object: json)
        print("infoView request",jsons)
        apiManager.apiPostView(serviceName: serviceUrl, parameters: jsons as! [String : Any], completionHandler: {
            (response, error) in
            if let response = response {
                let details = try? newJSONDecoder().decode(PatientListJSONModel.self, from: response)
                data(details, true)

            }else{
                data(nil, true)

            }
        })
    }
}
extension UserInfoViewController :UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.cellViewModel = userInfoModel[indexPath.row]

//        cell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.1, shadowPathInset: (dx: 8, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Did Select for hub push
        if targetOption == "Book Appointment" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier:"BookAppointmentVC") as? BookAppointmentVC
//            v1?.infoViewModel = userInfoModel[indexPath.row]
            v1?.userInfoModels = userInfoModel[indexPath.row]
                self.navigationController?.pushViewController(v1!, animated: true)
        }else if targetOption == "Appointment Status"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier:"AppointmentHistoryVC") as? AppointmentHistoryVC
                self.navigationController?.pushViewController(v1!, animated: true)
        }
        else if targetOption == "Lab Result"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier:"LAbResultViewController") as? LAbResultViewController
                self.navigationController?.pushViewController(v1!, animated: true)
        }else if targetOption == "OPD History"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let v1 = storyboard.instantiateViewController(withIdentifier:"OPDHistoryVC") as? OPDHistoryVC
                self.navigationController?.pushViewController(v1!, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
}
