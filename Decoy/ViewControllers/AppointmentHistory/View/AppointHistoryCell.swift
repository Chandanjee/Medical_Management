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
            let statusss = cellViewModel?.visit.visitID
            let date = cellViewModel?.visit.visitDate

            let locationCamp = cellViewModel?.masCamp.landMark
            if status == "" {
                self.lblAppointmentStatus.text = ""
            }else if status == "c" ||  status == "C"{
                self.lblAppointmentStatus.textColor = .green
                self.lblAppointmentStatus.text = "Completed"
                self.btnCancel.isHidden = true
                self.btnReshdule.isHidden = true
            }else if status == "x" ||  status == "X"{
                self.lblAppointmentStatus.textColor = .red
                self.lblAppointmentStatus.text = "Not Visited"
                self.btnCancel.isHidden = true
                self.btnReshdule.isHidden = true
            }else if status == "p" ||  status == "P" || status == "n" ||  status == "N" {
                self.lblAppointmentStatus.textColor = .yellow
                self.lblAppointmentStatus.text = "Awating Consultant"
            }
            
            self.lblAppointmentStatus.text = status
            if let camp = locationCamp {
                self.lblCampLocation.text = camp
            }
            let timeInterval = TimeInterval((cellViewModel?.visit.visitDate)!)
                      // create NSDate from Double (NSTimeInterval)
            let myNSDate = Date(timeIntervalSince1970: timeInterval)

//                      print(myNSDate)
            let formatDate = DateFormatter()
//            formatDate.locale = Locale(identifier: "UTC")

               formatDate.dateFormat = "dd-MM-yyyy"
            let drawDate = formatDate.string(from: myNSDate)
            let formatDate1 = DateFormatter()
               formatDate1.dateFormat = "hh:mm a"
            let drawDate1 = formatDate1.string(from: myNSDate)
           
            self.lblAppointmentdate.text = drawDate
            self.lblAppointmentTime.text = drawDate1
            
        }
    }
    
    @IBAction func buttonDeleteAction(_ sender: UIButton) {
//             buttonPressed()
        print("Delete")
        cellDelegate?.didPressButton(tag: sender.tag, Status: true)
    }
    
    @IBAction func buttonReschduleAction(_ sender: UIButton) {
//             buttonPressed()
        print("Delete ===")
        cellDelegate?.didPressButton(tag: sender.tag, Status: false)
    }
}
