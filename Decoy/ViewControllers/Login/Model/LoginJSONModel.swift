//
//  LoginJSONModel.swift
//  Decoy
//
//  Created by MAC on 26/10/21.
//

import Foundation
import UIKit

// MARK: - LoginJSONModel
struct LoginJSONModel: Codable {
    let response: [Response]
    let status: Int
    let message: String
}

// MARK: - Response
struct Response: Codable {
    let patientID: Int
    let address: String
    let cityID, dateOfBirth, districtID: Int
    let formSubmitted: JSONNull?
    let identificationNo, laborRegistered: String
    let lastChgDate: JSONNull?
    let mobileNumber, occuption, patientName: String
    let patientType: JSONNull?
    let loginPwd: String
    let pincode: Int
    let campID: JSONNull?
    let administrativeSexID: AdministrativeSexID
    let religionID: JSONNull?
    let regNo: String
    let stateID: JSONNull?
    let uhidNo: String
    let age: Int

    enum CodingKeys: String, CodingKey {
        case patientID = "patientId"
        case address
        case cityID = "cityId"
        case dateOfBirth
        case districtID = "districtId"
        case formSubmitted, identificationNo, laborRegistered, lastChgDate, mobileNumber, occuption, patientName, patientType, loginPwd, pincode
        case campID = "camp_id"
        case administrativeSexID = "administrativeSexId"
        case religionID = "religionId"
        case regNo
        case stateID = "stateId"
        case uhidNo, age
    }
}

// MARK: - AdministrativeSexID
struct AdministrativeSexID: Codable {
    let administrativeSexID: Int
    let administrativeSexCode, administrativeSexName: String

    enum CodingKeys: String, CodingKey {
        case administrativeSexID = "administrativeSexId"
        case administrativeSexCode, administrativeSexName
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
