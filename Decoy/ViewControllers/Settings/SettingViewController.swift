//
//  SettingViewController.swift
//  Decoy
//
//  Created by MAC on 24/10/21.
//

import UIKit
import MBProgressHUD

class SettingViewController: UIViewController {
    var tabController: VC_TYPE = .Profile
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnBack:UIButton!
    private let apiManager = NetworkManager()

    let serviceUrl = BaseUrl.baseURL + "getPatientList"
    var userInfoModel = [ResponsesData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FamilyListCell.nib, forCellReuseIdentifier: FamilyListCell.identifier)
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
        MBProgressHUD.showAdded(to: view, animated: true)
        let usermobile = UserDefaults.standard.value(forKey: "LoginMobilenum") as? String

        API_getViewAllTickets(json: PatientRequestModel.init(username: usermobile!), data: {
            
            responseData,status  in
            
            print(responseData?.response.count as Any)
//                self?.userResultModel = response?.result ?? []
            let dataResult = responseData?.response
            if dataResult?.count ?? 0 > 0{
                self.userInfoModel = dataResult ?? []
            }else{
                self.userInfoModel =  []
            }
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)

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
extension SettingViewController :UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInfoModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FamilyListCell", for: indexPath) as? FamilyListCell else {
            fatalError("can't dequeue CustomCell")
        }
        cell.cellViewModel = userInfoModel[indexPath.row]

//        cell.addShadow(backgroundColor: .white, cornerRadius: 13, shadowRadius: 5, shadowOpacity: 0.1, shadowPathInset: (dx: 8, dy: 6), shadowPathOffset: (dx: 0, dy: 2))
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //  Did Select for hub push
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // this will turn on `masksToBounds` just before showing the cell
        cell.contentView.layer.masksToBounds = true
    }
}
