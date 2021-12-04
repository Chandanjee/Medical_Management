//
//  OPDTableCell.swift
//  Decoy
//
//  Created by MAC on 01/12/21.
//

import UIKit
protocol OPDButtonCellDelegate : AnyObject {
    func didOPDPressButton(tag: Int,Status:Bool)
}

class OPDTableCell: UITableViewCell {
    @IBOutlet weak var lblDepartmentName:UILabel!
    @IBOutlet weak var lblPatientName:UILabel!
    @IBOutlet weak var lblDate:UILabel!
    @IBOutlet weak var lblMMUName:UILabel!
    @IBOutlet weak var btnSLip:UIButton!
    @IBOutlet weak var btnReferral:UIButton!
    @IBOutlet weak var viewBackgrounds:UIView!

   weak  var cellDelegate: OPDButtonCellDelegate?

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Utility.addAllSidesShadowOnView(viewBackgrounds)
        Utility.setViewCornerRadius(viewBackgrounds, 8)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var cellViewModel: OPDResponse? {
        didSet {
            let status = cellViewModel?.masDepartment.departmentName
            let locationCamp = cellViewModel?.masCamp.masMMU.mmuName
            self.lblDepartmentName.text = status
            if let camp = locationCamp {
                self.lblMMUName.text = camp
            }
            let timeInterval = TimeInterval((cellViewModel?.visit.visitDate)!)
                      // create NSDate from Double (NSTimeInterval)
            let myNSDate = Date(timeIntervalSince1970: timeInterval)
//                      print(myNSDate)
            let formatDate = DateFormatter()
               formatDate.dateFormat = "dd-MM-yyyy"
            let drawDate = formatDate.string(from: myNSDate)

            self.lblDate.text = drawDate
            self.lblPatientName.text = cellViewModel?.patient.patientName
            
        }
    }
    
    @IBAction func buttonRefferalAction(_ sender: UIButton) {
//             buttonPressed()
        print("buttonRefferalAction")
        cellDelegate?.didOPDPressButton(tag: sender.tag, Status: true)
    }
    
    @IBAction func buttonSlipAction(_ sender: UIButton) {
//             buttonPressed()
        print("buttonSlipAction ===")
        cellDelegate?.didOPDPressButton(tag: sender.tag, Status: false)
    }
}
