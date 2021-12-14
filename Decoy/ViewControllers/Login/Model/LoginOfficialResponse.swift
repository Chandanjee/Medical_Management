//
//  LoginOfficialResponse.swift
//  Decoy
//
//  Created by MAC on 13/12/21.
//

import Foundation

struct LoginOfficialResponse:Codable {
    let response: OfficialResponse
    let status: Int
    let message: String
}

struct OfficialResponse: Codable {
    let userID: Int
    let emailAddress, mobileNo, password, userName: String
    let roleID, levelOfUser, districtID, mmuID: String
    let cityID, stateID: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case emailAddress, mobileNo, password, userName
        case roleID = "roleId"
        case levelOfUser
        case districtID = "districtId"
        case mmuID = "mmuId"
        case cityID = "cityId"
        case stateID = "stateId"
    }
}
