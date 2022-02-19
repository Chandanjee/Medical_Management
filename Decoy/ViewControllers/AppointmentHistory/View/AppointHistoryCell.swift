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
            let status = cellViewModel?.visit?.visitStatus
            let dt = Date()
            let inputFormatter = DateFormatter()
            inputFormatter.dateFormat = "dd-MM-yyyy"
            let inputFormatter1 = DateFormatter()
            inputFormatter1.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let resultStringDate = inputFormatter.string(from: dt)
            let statusss = cellViewModel?.visit?.visitId
            let dateStr = cellViewModel?.visit?.visitDateData
            if dateStr == "" || dateStr == nil {
                self.lblAppointmentStatus.text = ""
                self.btnCancel.isHidden = true
                self.btnReshdule.isHidden = true
                return
            }
            let convertDate = inputFormatter1.date(from: dateStr!)
            let convertStringDate = inputFormatter.string(from: convertDate!)

            let resultDate1 = inputFormatter.date(from: convertStringDate )
            let resultDate2 = inputFormatter.date(from: resultStringDate )

//            let dateType = resultDate2?.isEqualTo(resultDate1!)
//            let dateType1 = resultDate2?.isGreaterThan(resultDate1!)
//print("Date compare in ",dateType,dateType1)
            let dayDiff =  diffRenceDate(firstDate: resultDate2!, secondDate: resultDate1!)
            
            let locationCamp = cellViewModel?.masCamp?.landMark
            if status == "" {
                self.lblAppointmentStatus.text = ""
                self.btnCancel.isHidden = true
                self.btnReshdule.isHidden = true
            }else if status == "c" ||  status == "C"{
                self.lblAppointmentStatus.textColor = .green
                self.lblAppointmentStatus.text = "Completed"
                self.btnCancel.isHidden = true
                self.btnReshdule.isHidden = true
            }else if status == "x" ||  status == "X"{
//                check date diffrence
//                if date  == 0 then calcelled else not visted in red color both
                if dayDiff >= 0{
                    self.lblAppointmentStatus.backgroundColor = .red
                    self.lblAppointmentStatus.text = "Cancelled"
                    self.lblAppointmentStatus.backgroundColor = .black

                    self.btnCancel.isHidden = true
                    self.btnReshdule.isHidden = true
                }else{
                    self.lblAppointmentStatus.textColor = .red
                    self.lblAppointmentStatus.text = "Not Visited"
                    self.lblAppointmentStatus.backgroundColor = .black
                    self.btnCancel.isHidden = true
                    self.btnReshdule.isHidden = true
                }
               
            }else if status == "p" ||  status == "P" || status == "n" ||  status == "N" {
                //                check date diffrence
                //                if date  == 0 then Awating Consultant else not visted in red color
                if dayDiff >= 0{
                    self.lblAppointmentStatus.backgroundColor = .yellow
                    self.lblAppointmentStatus.text = "Awating Consultant"
                    self.lblAppointmentStatus.textColor = .black
                    self.btnCancel.isHidden = false
                    self.btnReshdule.isHidden = false
                }else{
                    self.lblAppointmentStatus.backgroundColor = .red
                    self.lblAppointmentStatus.text = "Not Visited"
                    self.lblAppointmentStatus.textColor = .black
                    self.btnCancel.isHidden = true
                    self.btnReshdule.isHidden = true
                }
                            
            }else if status == "w" || status == "W"{
//                check date diffrence
                //Pending in yello color else not visited
                if dayDiff >= 0{
                    self.lblAppointmentStatus.backgroundColor = .yellow
                    self.lblAppointmentStatus.text = "Pending"
                    self.lblAppointmentStatus.textColor = .black
                    self.btnCancel.isHidden = true
                    self.btnReshdule.isHidden = true
                }else{
                    self.lblAppointmentStatus.backgroundColor = .red
                    self.lblAppointmentStatus.text = "Not Visited"
                    self.lblAppointmentStatus.textColor = .black
                    self.btnCancel.isHidden = true
                    self.btnReshdule.isHidden = true
                }
            }
            
//            self.lblAppointmentStatus.text = status
            if let camp = locationCamp {
                self.lblCampLocation.text = camp
            }
            let timeInterval = TimeInterval((cellViewModel?.visit?.visitDate)!)
                      // create NSDate from Double (NSTimeInterval)
            let myNSDate = Date(timeIntervalSince1970: timeInterval)

//                      print(myNSDate)
            let formatDate = DateFormatter()
//            formatDate.locale = Locale(identifier: "UTC")

               formatDate.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let date = formatDate.date(from: dateStr!)
            formatDate.dateFormat = "dd-MM-yyyy"
            let drawDate = formatDate.string(from: date!)
            let formatDate1 = DateFormatter()
               formatDate1.dateFormat = "hh:mm a"
            let drawDate1 = formatDate1.string(from: date!)
           
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
    func diffRenceDate(firstDate:Date,secondDate:Date) -> Int{
        let calendar = Calendar.current

        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: secondDate)

        let components = calendar.dateComponents([.day], from: date1, to: date2)
        return components.day!
    }
}
