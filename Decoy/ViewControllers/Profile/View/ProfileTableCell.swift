//
//  ProfileTableCell.swift
//  Decoy
//
//  Created by Chandan Jee on 24/10/21.
//  Copyright © 2020 intek. All rights reserved.
//
import UIKit

class ProfileTableCell: UITableViewCell {
    
    @IBOutlet weak var viewShadow: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    class var identifierProfile: String { return String(describing: self) }
    class var nibProfile: UINib { return UINib(nibName: identifierProfile, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        Utility.addAllSidesShadowOnView(viewShadow)
        Utility.setViewCornerRadius(viewShadow, 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func loadData(entry: Entry) {
        let image = UIImage(named: entry.image)
        imgView.image = image
        labelTitle.text = entry.title
    }
}
