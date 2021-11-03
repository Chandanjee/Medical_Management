//
//  ProfileLogoutTableCell.swift
//  Decoy
//
//  Created by Chandan Jee on 24/10/21.
//  Copyright © 2020 intek. All rights reserved.
//
import UIKit

class ProfileLogoutTableCell: UITableViewCell {
    
    @IBOutlet weak var viewLogout: UIView!
    class var identifierLogout: String { return String(describing: self) }
    class var nibLogout: UINib { return UINib(nibName: identifierLogout, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utility.setViewCornerRadius(viewLogout, 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
