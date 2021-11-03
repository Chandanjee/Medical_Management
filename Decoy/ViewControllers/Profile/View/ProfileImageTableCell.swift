//
//  ProfileImageTableCell.swift
//  Decoy
//
//  Created by Chandan Jee on 24/10/21.
//  Copyright © 2020 intek. All rights reserved.
//

import UIKit

class ProfileImageTableCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var callIcon: UIImageView!
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var viewImageBG: UIView!
    @IBOutlet weak var buttonCamera: UIButton!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelEmailId: UILabel!
    @IBOutlet weak var buttonMobileNumber: UIButton!
    
    var profileDelegate: ProfileViewDelegate?
    
    class var identifierProfileImage: String { return String(describing: self) }
    class var nibProfileImage: UINib { return UINib(nibName: identifierProfileImage, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        Utility.addAllSidesShadowOnView(viewShadow)
        Utility.createCircularView(viewImageBG)
        Utility.setViewCornerRadius(viewShadow, 10)
        Utility.createCircularView(buttonCamera)
        callIcon.image = callIcon.image?.withRenderingMode(.alwaysTemplate)
        callIcon.tintColor = ColorCode.greenColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(withEditing delegate: ProfileViewDelegate?, image: UIImage?, profile: [String:Any]) {
        profileDelegate = delegate
        if image != nil {
            imgView.image = image
        }
//        let fullName = (profile[kFirstName] as? String ?? "") + " " + (profile[kLastName] as? String ?? "")
//        labelUsername.text = fullName
//        labelEmailId.text = profile[kEmail] as? String
//        let mobileNumber = UserDefaults.subscriberId ?? ""
//        buttonMobileNumber.setTitle(UserDefaults.subscriberId ?? "", for: .normal)
//
//        labelUsername.text = UserDefaults.userName
//        labelEmailId.text = UserDefaults.userEmail
    }
    
    @IBAction func tapCamera(_ sender: UIButton) {
        profileDelegate?.chooseProfileImageOption()
    }
}
