//
//  LABResponseModel.swift
//  Decoy
//
//  Created by MAC on 02/12/21.
//

import Foundation

struct LABResponseModel:Codable{
    let response: [LABResponse]
    let status: Int
    let message: String
}
struct LABResponse: Codable {
    let date, unit, result, range: String
    let enteredValidateBy, investigationName, orderHDID: String

    enum CodingKeys: String, CodingKey {
        case date, unit, result, range, enteredValidateBy, investigationName
        case orderHDID = "orderHdId"
    }
}

typealias labResponse = [LABResponse]
