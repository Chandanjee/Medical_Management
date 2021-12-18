//
//  CamPlanCell.swift
//  Decoy
//
//  Created by MAC on 15/12/21.
//

import UIKit
import CoreLocation


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
            let dateStr = cellViewModel?.campDateData
            //MARK: Date
            let formatDate1 = DateFormatter()
            formatDate1.dateFormat = "dd-MM-yyyy HH:mm:ss"
            let date = formatDate1.date(from: dateStr!)
            formatDate1.dateFormat = "dd-MM-yyyy"
            let drawDate = formatDate1.string(from: date!)

            self.campAvailableLbl.text = drawDate
            self.campDayLbl.text = cellViewModel?.day
            
            //MARK: Time
            let formatDate = DateFormatter()
            formatDate.dateFormat = "HH:mm:ss"
            let strt = cellViewModel?.startTime
            
            let dateTime = formatDate.date(from: strt!)
            formatDate.dateFormat = "hh:mm a"
         let drawDate1 = formatDate.string(from: dateTime!)
            self.campStartTimeLbl.text = drawDate1
            
            formatDate.dateFormat = "HH:mm:ss"
            let end = cellViewModel?.endTime
            let date2 = formatDate.date(from: end!)
            formatDate.dateFormat = "hh:mm a"
            let drawDate2 = formatDate.string(from: date2!)
            self.campEndTimeLbl.text = drawDate2
            
            //MARK: Distance
            self.campDistanceLbl.text = ""
            self.campLocation.text = cellViewModel?.location
            self.campLandmarkLbl.text = cellViewModel?.landMark
            
        }
    }
    
    func loadCellDataOne(lat:Double, long:Double, cellViewModel:CampResponse?) {
        let dateStr = cellViewModel?.campDateData
        //MARK: Date
        let formatDate1 = DateFormatter()
        formatDate1.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let date = formatDate1.date(from: dateStr!)
        formatDate1.dateFormat = "dd-MM-yyyy"
        let drawDate = formatDate1.string(from: date!)

        self.campAvailableLbl.text = drawDate
        self.campDayLbl.text = cellViewModel?.day
        
        //MARK: Time
        let formatDate = DateFormatter()
        formatDate.dateFormat = "HH:mm:ss"
        let strt = cellViewModel?.startTime
        
        let dateTime = formatDate.date(from: strt!)
        formatDate.dateFormat = "hh:mm a"
     let drawDate1 = formatDate.string(from: dateTime!)
        self.campStartTimeLbl.text = drawDate1
        
        formatDate.dateFormat = "HH:mm:ss"
        let end = cellViewModel?.endTime
        let date2 = formatDate.date(from: end!)
        formatDate.dateFormat = "hh:mm a"
        let drawDate2 = formatDate.string(from: date2!)
        self.campEndTimeLbl.text = drawDate2
        
        //MARK: Distance
        let latPerson = Double(cellViewModel?.lattitude ?? Int(0.0))
        let longPerson = Double(cellViewModel?.longitude ?? Int(0.0))
        let dis = haversineDinstance(la1: lat, lo1: long, la2: latPerson, lo2: longPerson)
print("Distance",dis/1000)
        
        let myLocation = CLLocation(latitude: lat, longitude: long)
        //My buddy's location
        let myBuddysLocation = CLLocation(latitude: latPerson, longitude: longPerson)

        //Measuring my distance to my buddy's (in km)
        let distance = myLocation.distance(from: myBuddysLocation) / 1000
        print(String(format: "The distance to my buddy is %.01fkm", distance))

        self.campDistanceLbl.text = String(format: "%.01fkm", distance)
        self.campLocation.text = cellViewModel?.location
        self.campLocation.frame.size.height = self.campLocation.optimalHeightLabel

        self.campLandmarkLbl.text = cellViewModel?.landMark
        
    }
    
    func haversineDinstance(la1: Double, lo1: Double, la2: Double, lo2: Double, radius: Double = 6367444.7) -> Double {

    let haversin = { (angle: Double) -> Double in
        return (1 - cos(angle))/2
    }

    let ahaversin = { (angle: Double) -> Double in
        return 2*asin(sqrt(angle))
    }

    // Converts from degrees to radians
    let dToR = { (angle: Double) -> Double in
        return (angle / 360) * 2 * .pi
    }

    let lat1 = dToR(la1)
    let lon1 = dToR(lo1)
    let lat2 = dToR(la2)
    let lon2 = dToR(lo2)

    return radius * ahaversin(haversin(lat2 - lat1) + cos(lat1) * cos(lat2) * haversin(lon2 - lon1))
    }
}
