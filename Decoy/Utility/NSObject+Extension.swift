//
//  NSObject+Extension.swift
//  Decoy
//
//  Created by MAC on 24/10/21.
//

import Foundation
import UIKit

extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
    
}
