//
//  CamPlanCell.swift
//  Decoy
//
//  Created by MAC on 15/12/21.
//

import UIKit

class CamPlanCell: UITableViewCell {
    @IBOutlet weak var campAvailableLbl:UILabel!
    @IBOutlet weak var campDayLbl:UILabel!
    @IBOutlet weak var campStartTimeLbl:UILabel!
    @IBOutlet weak var campEndTimeLbl:UILabel!
    @IBOutlet weak var campDistanceLbl:UILabel!
    @IBOutlet weak var campLocation:UILabel!
    @IBOutlet weak var campLandmarkLbl:UILabel!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
