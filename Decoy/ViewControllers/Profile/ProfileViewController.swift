//
//  ProfileViewController.swift
//  Decoy
//
//  Created by mrigank.sahai on 14/10/21.
//

import UIKit

protocol ProfileViewDelegate {
    func chooseProfileImageOption()
}

class ProfileViewController: UIViewController,ProfileViewDelegate {
    
    var tabController: VC_TYPE = .Setting

    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var tableViewProfile: UITableView!
    @IBOutlet weak var profileBGImageView: UIImageView!
    let profileData = ProfileData()
    var profileImage: UIImage?
    var dataDict: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        // Do any additional setup after loading the view.
    }
    fileprivate func registerCells() {
        tableViewProfile.estimatedRowHeight = 300
        tableViewProfile.rowHeight = UITableView.automaticDimension

        tableViewProfile.register(ProfileImageTableCell.nibProfileImage, forCellReuseIdentifier: ProfileImageTableCell.identifierProfileImage)
        tableViewProfile.register(ProfileTableCell.nibProfile, forCellReuseIdentifier: ProfileTableCell.identifierProfile)
        tableViewProfile.register(ProfileLogoutTableCell.nibLogout, forCellReuseIdentifier: ProfileLogoutTableCell.identifierLogout)
    }

    func chooseProfileImageOption() {
        
    }
    
}

extension ProfileViewController:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return profileData.data.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTableCell.identifierProfileImage, for: indexPath) as? ProfileImageTableCell {
                cell.loadData(withEditing: self, image: profileImage, profile: self.dataDict)
                cell.selectionStyle = .none
                return cell
            }
//        case 1:
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableCell.identifierProfile, for: indexPath) as? ProfileTableCell {
                cell.loadData(entry: profileData.data[indexPath.row])
                cell.selectionStyle = .none
                return cell
            }
//        default:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.profileLogoutTableCell, for: indexPath) as? ProfileLogoutTableCell {
//                cell.selectionStyle = .none
//                return cell
//            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                print("Account")
//                Utility.pushControllerWithAnimation(Storyboard.profile, ControllerIdentifier.newUpdateViewController, self)
            case 1:
                print("Settings")
//                Utility.pushControllerWithAnimation(Storyboard.profile, ControllerIdentifier.settingsVC, self)
//                Utility.pushControllerWithAnimation(Storyboard.profile, ControllerIdentifier.privacyPolicyVC, self)
            case 2:
                print("Backup")
            case 3:
                print("Back Up ")
            case 4:
                print("Support")
            default: break
            }
        case 2:
            print("Logout")
//            Utility.performTaskInMainQueue {
//                let storyboard = UIStoryboard(name: Storyboard.main, bundle: nil)
//                let logoutVC = storyboard.instantiateViewController(withIdentifier: ControllerIdentifier.logoutVC) as! LogoutVC
////                logoutVC.modalPresentationStyle = .overCurrentContext
////                logoutVC.modalTransitionStyle = .crossDissolve
//                logoutVC.view.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.85)
////                logoutVC.view.isOpaque = false
//                logoutVC.callBackToPushLoginVC = { [weak self] in
//                    guard let weakSelf = self else { return }
//                    weakSelf.callAPI_Logout()
//                }
//                self.navigationController?.pushViewController(logoutVC, animated: true)
////                self.navigationController?.popToViewController(logoutVC, animated: true)
////                self.navigationController?.popToRootViewController(animated: true)
////                self.present(logoutVC, animated: true, completion: nil)
//            }
        default: break
        }
    }
}
