//
//  UserInfoCell.swift
//  Decoy
//
//  Created by MAC on 25/10/21.
//

import UIKit

class UserInfoCell: UITableViewCell {
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var lblMobileNo:UILabel!
    @IBOutlet weak var lblGender:UILabel!
    @IBOutlet weak var lblUHID:UILabel!
    @IBOutlet weak var btnNext:UIButton!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnNext.layer.cornerRadius = 0.5 * btnNext.bounds.size.width //btnNext.frame.size.width / 2
        btnNext.clipsToBounds = true
        // Initialization code
//        contentView.addShadowView()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .clear // very important
           layer.masksToBounds = false
           layer.shadowOpacity = 0.33
           layer.shadowRadius = 5
           layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor

           // add corner radius on `contentView`
           contentView.backgroundColor = .white
           contentView.layer.cornerRadius = 8
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
}
