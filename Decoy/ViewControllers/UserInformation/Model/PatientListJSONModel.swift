//
//  PatientListJSONModel.swift
//  Decoy
//
//  Created by MAC on 27/10/21.
//

import Foundation
import UIKit


// MARK: - PatientListJSONModel
struct PatientListJSONModel: Codable {
    let response: [ResponsesData]
    let status: Int
    let message: String
}

// MARK: - Response
struct ResponsesData: Codable {
    let patientID: Int
    let address: String?
    let cityID: Int?
    let dateOfBirth: Int
    let districtID: Int?
    let formSubmitted: JSONNull?
    let identificationNo, laborRegistered: String?
    let lastChgDate: JSONNull?
    let mobileNumber: String
    let occuption: String?
    let patientName: String
    let patientType, loginPwd: String?
    let pincode, campID: Int?
    let administrativeSexID: AdministrativeSexIDd
    let religionID: JSONNull?
    let regNo: String?
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
struct AdministrativeSexIDd: Codable {
    let administrativeSexID: Int
    let administrativeSexCode: AdministrativeSexCode
    let administrativeSexName: AdministrativeSexName

    enum CodingKeys: String, CodingKey {
        case administrativeSexID = "administrativeSexId"
        case administrativeSexCode, administrativeSexName
    }
}

enum AdministrativeSexCode: String, Codable {
    case f = "F"
    case m = "M"
}

enum AdministrativeSexName: String, Codable {
    case female = "FEMALE"
    case male = "MALE"
}

// MARK: - Encode/decode helpers
/*
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
*/
