//
//  AppointHistoryCell.swift
//  Decoy
//
//  Created by MAC on 29/11/21.
//

import UIKit

protocol HistoryButtonCellDelegate : AnyObject {
    func didPressButton(tag: Int,Status:Bool)
}

class AppointHistoryCell: UITableViewCell {
    @IBOutlet weak var lblCampLocation:UILabel!
    @IBOutlet weak var lblAppointmentTime:UILabel!
    @IBOutlet weak var lblAppointmentdate:UILabel!
    @IBOutlet weak var lblAppointmentStatus:UILabel!
    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var btnReshdule:UIButton!
    @IBOutlet weak var viewBackground:UIView!

   weak  var cellDelegate: HistoryButtonCellDelegate?

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
    var cellViewModel: HistoryResponse? {
        didSet {
            let status = cellViewModel?.visit.visitStatus
            let locationCamp = cellViewModel?.masCamp.landMark
            self.lblAppointmentStatus.text = status
            if let camp = locationCamp {
                self.lblCampLocation.text = camp
            }
            self.lblAppointmentdate.text = ""
            self.lblAppointmentTime.text = ""
            
        }
    }
    
    @IBAction func buttonDeleteAction(_ sender: UIButton) {
//             buttonPressed()
        cellDelegate?.didPressButton(tag: sender.tag, Status: true)
    }
    
    @IBAction func buttonReschduleAction(_ sender: UIButton) {
//             buttonPressed()
        cellDelegate?.didPressButton(tag: sender.tag, Status: false)
    }
}
