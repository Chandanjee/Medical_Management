//
//  PendingApprovalCell.swift
//  Decoy
//
//  Created by MAC on 13/12/21.
//

import UIKit

class PendingApprovalCell: UICollectionViewCell {
    @IBOutlet weak var imageViews:UIImageView!
    @IBOutlet weak var labelName:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        Utility.setViewCornerRadius(, 5)

    }
    
    func loadCollectionData(entry: EntryData) {
        let image = UIImage(named: entry.image)
        imageViews.image = image
        labelName.text = entry.title
    }
    
    func configure() {
     contentView.layer.cornerRadius = 20
     contentView.layer.borderWidth = 1.0
     contentView.layer.borderColor = UIColor.clear.cgColor
     contentView.layer.masksToBounds = true
     layer.shadowColor = UIColor.black.cgColor
     layer.shadowOffset = CGSize(width: 0, height: 2.0)
     layer.shadowRadius = 2.0
     layer.shadowOpacity = 0.5
     layer.masksToBounds = false
//     layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
    }
  
}
