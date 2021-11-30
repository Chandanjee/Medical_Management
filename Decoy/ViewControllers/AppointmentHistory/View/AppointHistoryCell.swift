//
//  AppointHistoryCell.swift
//  Decoy
//
//  Created by MAC on 29/11/21.
//

import UIKit

class AppointHistoryCell: UITableViewCell {
    @IBOutlet weak var lblCampLocation:UILabel!
    @IBOutlet weak var lblAppointmentTime:UILabel!
    @IBOutlet weak var lblAppointmentdate:UILabel!
    @IBOutlet weak var lblAppointmentStatus:UILabel!
    @IBOutlet weak var btnCancel:UIButton!
    @IBOutlet weak var btnReshdule:UIButton!

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
    var cellViewModel: HistoryResponse? {
        didSet {
            let status = cellViewModel?.visit.visitStatus
            let locationCamp = cellViewModel?.masCamp.status
            self.lblAppointmentStatus.text = status
            if let camp = locationCamp as? String {
                self.lblCampLocation.text = camp
            }
            
        }
    }
}
