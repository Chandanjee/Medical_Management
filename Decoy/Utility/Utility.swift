//
//  Utility.swift
//  Decoy
//
//  Created by Chandan Jee on 22/10/21.
//
import Foundation
import UIKit
import MBProgressHUD
import SystemConfiguration
//import MaterialComponents.MaterialSnackbar
import CoreLocation
import CoreTelephony

//MARK: Utility
public class Utility : NSObject {
   static func setViewCornerRadius(_ view: UIView, _ radius: CGFloat) {
       view.layer.cornerRadius = radius
       view.clipsToBounds = false
   }
   
   static func createCircularView(_ view: UIView) {
       view.layer.cornerRadius = view.frame.size.width/2
       view.clipsToBounds = true
   }
   
   static func addAllSidesShadowOnView(_ view: UIView) {
       view.layer.shadowColor = UIColor.black.cgColor
       view.layer.shadowOffset = CGSize(width: 0, height: 1)
       view.layer.shadowRadius = 2.0
       view.layer.shadowOpacity = 0.5
       view.layer.masksToBounds = false
   }
   static func AllSidesShadowOnView(_ view: UIView) {
       view.layer.shadowColor = UIColor.darkGray.cgColor
       view.layer.shadowOffset = CGSize(width: 0, height: 1)
       view.layer.shadowRadius = 5.0
       view.layer.shadowOpacity = 0.5
       view.layer.masksToBounds = false
   }
   
   static func addBottomSidesShadowOnView(_ view: UIView) {
       view.layer.shadowColor = UIColor.black.cgColor
       view.layer.shadowOffset = CGSize(width: 0.0 , height: 1)
       view.layer.shadowOpacity = 0.5
       view.layer.shadowRadius = 0.0
       view.layer.masksToBounds = false
   }
   
   
   @objc public class func getGmtTime() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd MMM yyyy HH:MM:SS"
        let dateString = formatter.string(from: now)
        let gmtTime = dateString + " GMT"
        return gmtTime
    }
   
   @objc public class func getRefID() -> String {
         let id = Date().inDigits
         let refId = String(describing: id)
         return refId
     }
   
   
   class func getIP() -> String {
       var ip = ""
       var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
       if getifaddrs(&ifaddr) == 0 {
           var ptr = ifaddr
           while ptr != nil {
               defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
               let interface = ptr?.pointee
               let addrFamily = interface?.ifa_addr.pointee.sa_family
               if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                   let name = String(cString: (interface?.ifa_name)!)
                   if name == "en0" {
                       // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                       var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                       getnameinfo(interface?.ifa_addr, socklen_t((interface?.ifa_addr.pointee.sa_len)!), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                       ip = String(cString: hostname)
                   }
               }
           }
           freeifaddrs(ifaddr)
       }
       return ip
   }
   
   class func isInternetAvailable() -> Bool {
       var zeroAddress = sockaddr_in()
       zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
       zeroAddress.sin_family = sa_family_t(AF_INET)
       
       let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
           $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
               SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
           }
       }
       
       var flags = SCNetworkReachabilityFlags()
       if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
           return false
       }
       let isReachable = flags.contains(.reachable)
       let needsConnection = flags.contains(.connectionRequired)
       return (isReachable && !needsConnection)
   }
   
   func addAlertView(_ alertTitle: String, _ alertMessage: String, _ alertAction: String, _ controller: UIViewController) {
       let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
       let defaultAction = UIAlertAction(title: alertAction, style: .cancel, handler: nil)
       alertController.addAction(defaultAction)
       controller.present(alertController, animated: true, completion: nil)
   }
}


//MARK: Color
extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }

    convenience init(rgb: Int, a: CGFloat = 1.0) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            a: a
        )
    }
    
    convenience init(rgb: UInt) {
         self.init(rgb: rgb, alpha: 1.0)
     }

     convenience init(rgb: UInt, alpha: CGFloat) {
         self.init(
             red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
             green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
             blue: CGFloat(rgb & 0x0000FF) / 255.0,
             alpha: CGFloat(alpha)
         )
     }
}

//MARK: Application
extension UIApplication {

    var statusBarUIView: UIView? {

        if #available(iOS 13.0, *) {
            let tag = 3848245

            let keyWindow: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

            if let statusBar = keyWindow?.viewWithTag(tag) {
                return statusBar
            } else {
                let height = keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
                let statusBarView = UIView(frame: height)
                statusBarView.tag = tag
                statusBarView.layer.zPosition = 999999

                keyWindow?.addSubview(statusBarView)
                return statusBarView
            }

        } else {

            if responds(to: Selector(("statusBar"))) {
                return value(forKey: "statusBar") as? UIView
            }
        }
        return nil
      }
}

//MARK: UITableCell
extension UITableViewCell {
    func addShadow(backgroundColor: UIColor = .white, cornerRadius: CGFloat = 12, shadowRadius: CGFloat = 5, shadowOpacity: Float = 0.1, shadowPathInset: (dx: CGFloat, dy: CGFloat), shadowPathOffset: (dx: CGFloat, dy: CGFloat)) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = UIBezierPath(roundedRect: bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy).offsetBy(dx: shadowPathOffset.dx, dy: shadowPathOffset.dy), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        let whiteBackgroundView = UIView()
        whiteBackgroundView.backgroundColor = backgroundColor
        whiteBackgroundView.layer.cornerRadius = cornerRadius
        whiteBackgroundView.layer.masksToBounds = true
        whiteBackgroundView.clipsToBounds = false
        
        whiteBackgroundView.frame = bounds.insetBy(dx: shadowPathInset.dx, dy: shadowPathInset.dy)
//        insertSubview(whiteBackgroundView, at: 0)
        self.contentView.addSubview(whiteBackgroundView)
        self.contentView.sendSubviewToBack(whiteBackgroundView)
    }
}

//MARK: UIView
extension UIView {
    func addShadowView(){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
//        self.layer.shadowOffset = CGSizeMake(1.0, 1.0)
        self.layer.shadowOffset = CGSize.init(width: 1.0, height: 1.0)
    }
}


//MARK: UITextView
extension UITextView :UITextViewDelegate
{
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = self.text.count > 0
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = self.text.count > 0
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}


func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}


//MARK:- Validation regular expressions
extension String {
    
    var trimWhiteSpace: String {
        let trimmedString = self.trimmingCharacters(in: CharacterSet.whitespaces)
        
        return trimmedString
    }
    
    var trailingSpacesTrimmed: String {
        var newString = self

        while newString.last?.isWhitespace == true {
            newString = String(newString.dropLast())
        }

        return newString
    }
    
    var urlEncoded: String? {
          let allowedCharacterSet = CharacterSet.alphanumerics.union(CharacterSet(charactersIn: "~-_."))
          return self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
      }
    
    func containsCaseInsec(_ string: String) -> Bool {
        return self.lowercased().range(of: string.lowercased()) != nil
    }
    //((\\+)|(00))
   func isValidMobileNumber() -> Bool {
        let mobileNoRegEx = "^[0-9]{8,16}$"
//        let mobileNoRegEx = "^\\d{3}-\\d{3}-\\d{4}$"
//        let mobileNoRegEx = "^[0-9+]{0,1}+[0-9]{5,16}$"
    
        let mobileNoTest = NSPredicate(format:"SELF MATCHES %@", mobileNoRegEx)
    let texts = mobileNoTest.evaluate(with: self)
    print("Number",texts)
        return texts
    }
    /*
    func isValidMobileNumber() -> Bool {
//        let PHONE_REGEX = "^((\\+)|(00))[0-9]{6,14}$"
        let PHONE_REGEX = "^(\\+)(?:[0-9] ?){6,14}[0-9]$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }*/
    
    func isContainsAllZeros() -> Bool {
        let mobileNoRegEx = "^0*$";
        let mobileNoTest = NSPredicate(format:"SELF MATCHES %@", mobileNoRegEx)
        return mobileNoTest.evaluate(with: self)
    }
    
    func isValidUserName() -> Bool {
        let nameRegEx = "^[a-zA-Z0-9\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
//      let passwordRegEx =  "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    var isEmail: Bool {
        let regex = try? NSRegularExpression(pattern: "^(\\w[.|-]?)*\\w+[@](\\w[.]?)*\\w+[.][a-z]{2,4}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    func isContainsAtleastOneSpecialCharacters() -> Bool{
//        let passwordRegEx = "^(?=.*?[$@$!%*#?&^)(]).{8,}$"
//        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{6,}$")
        let passwordRegEx = "^(?=.*[$@$#!%*?&]).{8,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordTest.evaluate(with: self)
    }
    
    func containsAlphaNumericOnly() -> Bool {
        let nameRegEx = "^[a-zA-Z0-9\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    func containsNumberOnly() -> Bool {
        let nameRegEx = "^[0-9]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        let test = nameTest.evaluate(with: self)
        print(test)
        return test
    }
    
    func containsAlphabetsOnly() -> Bool {
        let nameRegEx = "^[a-zA-Z]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func isValidName() -> Bool {
        
        let nameRegEx = "^[a-zA-Z\\s]+$"
        let nameTest = NSPredicate(format:"SELF MATCHES %@", nameRegEx)
        return nameTest.evaluate(with: self)
    }
    
    func checkTextSufficientComplexityUpperCase() -> Bool{

//        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let capitalLetterRegEx  = "(?=.*[A-Z]).{6,}$"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: self)
        print("\(capitalresult)")
        
        return capitalresult
    }
    func checkTextSufficientComplexityNumber() -> Bool{
//        let numberRegEx  = ".*[0-9]+.*"
       let numberRegEx  = "(?=.*[0-9]).{8,}$"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: self)
        print("\(numberresult)")
        return numberresult
    }
    func isValidPasswordATleastUpperLowerandSpecial() -> Bool {
        //let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~])[A-Za-z\\d !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{8,}"
        //safe to escape all regex chars
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~])[A-Za-z\\d !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func checkTextSufficientComplexity(text : String) -> Bool{


        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: text)
        print("\(capitalresult)")


        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: text)
        print("\(numberresult)")


        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)

        let specialresult = texttest2.evaluate(with: text)
        print("\(specialresult)")

        return capitalresult || numberresult || specialresult

    }
    //MARK:- >>>> removes all whitespace from a string, not just trailing whitespace <<<//
    func removeWhitespace() -> String {
//        return self.replaceString(" ", withString: "")
        return self.replacingOccurrences(of: " ", with: "")
    }

}

extension UIImageView {

func setImageTintColor(_ color: UIColor) {
    let tintedImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = tintedImage
    self.tintColor = color
  }
}

func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = format

    if let date = inputFormatter.date(from: dateString) {

        let outputFormatter = DateFormatter()
      outputFormatter.dateFormat =  "dd-MM-yyyy"

        return outputFormatter.string(from: date)
    }

    return nil
}
