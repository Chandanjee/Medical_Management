//
//  RescheduleTableCell.swift
//  Decoy
//
//  Created by MAC on 07/12/21.
//

import UIKit

class RescheduleTableCell: UITableViewCell {
    @IBOutlet weak var lblTimeSlot:UILabel!
    @IBOutlet weak var lblTime:UILabel!
    @IBOutlet weak var lblAppointmentCount:UILabel!
    @IBOutlet weak var viewBackground:UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        let bgColorView = UIView()
                bgColorView.backgroundColor =  UIColor(hexString: "#F0C15B") // F0C15B
                self.selectedBackgroundView = bgColorView
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.backgroundColor = .clear
    }
    
    func loadData(startTime:String, endTime:String) {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "hh:mm a"
        let start = formattedDateFromString(dateString: startTime, withFormat: "HH:mm:ss")
        let end = formattedDateFromString(dateString: endTime, withFormat: "HH:mm:ss")
        lblTime.text = start! + " - " + end!
    }
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = format

        if let date = inputFormatter.date(from: dateString) {

            let outputFormatter = DateFormatter()
          outputFormatter.dateFormat =  "hh:mm a"

            return outputFormatter.string(from: date)
        }

        return nil
    }
}
