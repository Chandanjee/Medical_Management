//
//  UserInfoViewController.swift
//  Decoy
//
//  Created by MAC on 25/10/21.
//

import UIKit
import Foundation

class UserInfoViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var btnBack:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserInfoCell.nib, forCellReuseIdentifier: UserInfoCell.identifier)
        // Do any additional setup after loading the view.
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
    
    func API_ListPatient(){
        func API_getViewAllTickets(json:PatientRequestModel, data:@escaping (_ result:PatientListJSONModel?,_ resultBool: Bool) -> ()){
            
        }
    }

}
extension UserInfoViewController :UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfoCell", for: indexPath) as? UserInfoCell else {
            fatalError("can't dequeue CustomCell")
        }
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
