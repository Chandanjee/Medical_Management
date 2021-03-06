//
//  DateTime.swift
//  Decoy
//
//  Created by Chandan Jee on 23/10/21.
//

import Foundation

extension Date {
    var inDigits: UInt64 {
        return UInt64((self.timeIntervalSince1970))
    }
    
    var millisecondsSince1970:Int64 {
          return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
      }

      init(milliseconds:Int64) {
          self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
      }
    
    static func getCurrentDate() -> String {

           let dateFormatter = DateFormatter()

//           dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.dateFormat = "dd-MM-yyyy"
           return dateFormatter.string(from: Date())

       }
}
