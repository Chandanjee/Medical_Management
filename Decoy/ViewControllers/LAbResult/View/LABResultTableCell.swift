//
//  LABResultTableCell.swift
//  Decoy
//
//  Created by MAC on 01/12/21.
//

import UIKit

protocol LAPResultButtonCellDelegate : AnyObject {
    func didLAPPressButton(tag: Int,Status:Bool)
}

class LABResultTableCell: UITableViewCell {
    @IBOutlet weak var lblResult:UILabel!
    @IBOutlet weak var lblInvestigationName:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblUnits:UILabel!
    @IBOutlet weak var lblValidatedBy:UILabel!
    @IBOutlet weak var lblRange:UILabel!
//    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var btnReport:UIButton!
    @IBOutlet weak var viewBackground:UIView!

   weak  var cellDelegate: LAPResultButtonCellDelegate?

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Utility.addAllSidesShadowOnView(viewBackground)
        Utility.setViewCornerRadius(viewBackground, 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var cellViewModel: LABResponse? {
        didSet {
//            let date = cellViewModel?.visit.visitDate
//            let timeInterval = TimeInterval((date)!)
            // create NSDate from Double (NSTimeInterval)
//            let myNSDate = Date(timeIntervalSince1970: timeInterval)
//            print(myNSDate)
//            let status = cellViewModel?.visit.visitStatus
//            let locationCamp = cellViewModel?.masCamp.landMark
            let formatter2 = DateFormatter()
            formatter2.dateFormat = "hh:mm a"
//            let start = formattedDateFromString(dateString: cellViewModel?.date, withFormat: "dd-MM-yyy")
            self.lblDate.text = cellViewModel?.date
            self.lblInvestigationName.text = cellViewModel?.investigationName
            self.lblResult.text = cellViewModel?.result
            self.lblUnits.text = cellViewModel?.unit
            self.lblRange.text = cellViewModel?.range
            self.lblValidatedBy.text = cellViewModel?.enteredValidateBy
            
        }
    }
    
    @IBAction func buttonDeleteAction(_ sender: UIButton) {
//             buttonPressed()
        print("Delete")
//        cellDelegate?.didPressButton(tag: sender.tag, Status: true)
    }
    
    @IBAction func buttonReportAction(_ sender: UIButton) {
//             buttonPressed()
        print("Report ===")
        cellDelegate?.didLAPPressButton(tag: sender.tag, Status: false)
    }
}
