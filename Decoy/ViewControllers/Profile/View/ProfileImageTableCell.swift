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
        let username = UserDefaults.standard.value(forKey: "Username") as? String
        let usermobile = UserDefaults.standard.value(forKey: "LoginMobilenum") as? String
        let email = UserDefaults.standard.value(forKey: "emailAddress") as? String

        labelUsername.text = username
        labelEmailId.text = email
        buttonMobileNumber.setTitle(usermobile ?? "", for: .normal)
//
    }
    
    @IBAction func tapCamera(_ sender: UIButton) {
        profileDelegate?.chooseProfileImageOption()
    }
}
