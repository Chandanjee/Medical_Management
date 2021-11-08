//
//  PatientRequestModel.swift
//  Decoy
//
//  Created by MAC on 08/11/21.
//

import Foundation
import UIKit

struct PatientRequestModel{
    
    var username: String
    
    init() {
        username = ""
    }
    
    init(username: String) {
        self.username = username
    }
    
    static func encode(object: PatientRequestModel) -> Any {
        var user = [String: Any]()
        
        user["username"] = object.username
        return user
    }
}
