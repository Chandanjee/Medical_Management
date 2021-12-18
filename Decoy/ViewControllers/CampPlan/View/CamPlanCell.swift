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
    @IBOutlet weak var campViews:UIView!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Utility.addAllSidesShadowOnView(campViews)
        Utility.setViewCornerRadius(campViews, 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var cellViewModel: CampResponse? {
        didSet {
            self.campAvailableLbl.text = ""
            self.campDayLbl.text = cellViewModel?.day
            
            let formatDate = DateFormatter()
            formatDate.dateFormat = "HH:mm:ss"
            let strt = cellViewModel?.startTime
            
            let date = formatDate.date(from: strt!)
            formatDate.dateFormat = "hh:mm a"
         let drawDate1 = formatDate.string(from: date!)
            self.campStartTimeLbl.text = drawDate1
            
            formatDate.dateFormat = "HH:mm:ss"
            let end = cellViewModel?.endTime
            let date2 = formatDate.date(from: end!)
            formatDate.dateFormat = "hh:mm a"
            let drawDate2 = formatDate.string(from: date2!)
            self.campEndTimeLbl.text = drawDate2
            self.campDistanceLbl.text = ""
            
            self.campLocation.text = cellViewModel?.location
            self.campLandmarkLbl.text = cellViewModel?.landMark
            
        }
    }
}
