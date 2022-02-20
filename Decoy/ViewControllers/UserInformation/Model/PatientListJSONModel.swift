//
//  PatientListJSONModel.swift
//  Decoy
//
//  Created by MAC on 27/10/21.
//

import Foundation
import UIKit

/*
// MARK: - PatientListJSONModel
struct PatientListJSONModel: Codable {
    let response: [ResponsesData]
    let status: Int
    let versinCode, versinApp, message: String

    enum CodingKeys: String, CodingKey {
        case response, status
        case versinCode = "versin_code"
        case versinApp = "versin_app"
        case message
    }
}

// MARK: - Response
struct ResponsesData: Codable {
    let patientID: Int
    let address, cityID: JSONNull?
    let dateOfBirth: Int
    let districtID, formSubmitted, identificationNo, laborRegistered: JSONNull?
    let lastChgDate: JSONNull?
    let mobileNumber: String
    let occuption: JSONNull?
    let patientName: String
    let patientType: JSONNull?
    let loginPwd: String
    let pincode: JSONNull?
    let campID: Int?
    let administrativeSexID: AdministrativeSexID
    let religionID, regNo, stateID: JSONNull?
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
    let administrativeSexCode, administrativeSexName: String

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
*/
struct PatientListJSONModel: Codable {
    let response : [ResponsesData]?
    let status : Int?
    let versin_code : String?
    let versin_app : String?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case response = "response"
        case status = "status"
        case versin_code = "versin_code"
        case versin_app = "versin_app"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent([ResponsesData].self, forKey: .response)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        versin_code = try values.decodeIfPresent(String.self, forKey: .versin_code)
        versin_app = try values.decodeIfPresent(String.self, forKey: .versin_app)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct ResponsesData: Codable {
    let patientId : Int?
    let address : String?
    let cityId : String?
    let dateOfBirth : Int?
    let districtId : String?
    let formSubmitted : String?
    let identificationNo : String?
    let laborRegistered : String?
    let lastChgDate : String?
    let mobileNumber : String?
    let occuption : String?
    let patientName : String?
    let patientType : String?
    let loginPwd : String?
    let pincode : String?
    let camp_id : Int?
    let administrativeSexId : AdministrativeSexIDd?
    let religionId : String?
    let regNo : String?
    let stateId : String?
    let uhidNo : String?
    let age : Int?

    enum CodingKeys: String, CodingKey {

        case patientId = "patientId"
        case address = "address"
        case cityId = "cityId"
        case dateOfBirth = "dateOfBirth"
        case districtId = "districtId"
        case formSubmitted = "formSubmitted"
        case identificationNo = "identificationNo"
        case laborRegistered = "laborRegistered"
        case lastChgDate = "lastChgDate"
        case mobileNumber = "mobileNumber"
        case occuption = "occuption"
        case patientName = "patientName"
        case patientType = "patientType"
        case loginPwd = "loginPwd"
        case pincode = "pincode"
        case camp_id = "camp_id"
        case administrativeSexId = "administrativeSexId"
        case religionId = "religionId"
        case regNo = "regNo"
        case stateId = "stateId"
        case uhidNo = "uhidNo"
        case age = "age"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        patientId = try values.decodeIfPresent(Int.self, forKey: .patientId)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        cityId = try values.decodeIfPresent(String.self, forKey: .cityId)
        dateOfBirth = try values.decodeIfPresent(Int.self, forKey: .dateOfBirth)
        districtId = try values.decodeIfPresent(String.self, forKey: .districtId)
        formSubmitted = try values.decodeIfPresent(String.self, forKey: .formSubmitted)
        identificationNo = try values.decodeIfPresent(String.self, forKey: .identificationNo)
        laborRegistered = try values.decodeIfPresent(String.self, forKey: .laborRegistered)
        lastChgDate = try values.decodeIfPresent(String.self, forKey: .lastChgDate)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
        occuption = try values.decodeIfPresent(String.self, forKey: .occuption)
        patientName = try values.decodeIfPresent(String.self, forKey: .patientName)
        patientType = try values.decodeIfPresent(String.self, forKey: .patientType)
        loginPwd = try values.decodeIfPresent(String.self, forKey: .loginPwd)
        pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
        camp_id = try values.decodeIfPresent(Int.self, forKey: .camp_id)
        administrativeSexId = try values.decodeIfPresent(AdministrativeSexIDd.self, forKey: .administrativeSexId)
        religionId = try values.decodeIfPresent(String.self, forKey: .religionId)
        regNo = try values.decodeIfPresent(String.self, forKey: .regNo)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        uhidNo = try values.decodeIfPresent(String.self, forKey: .uhidNo)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
    }

}

struct AdministrativeSexIDd: Codable {
    let administrativeSexId : Int?
    let administrativeSexCode : String?
    let administrativeSexName : String?

    enum CodingKeys: String, CodingKey {

        case administrativeSexId = "administrativeSexId"
        case administrativeSexCode = "administrativeSexCode"
        case administrativeSexName = "administrativeSexName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        administrativeSexId = try values.decodeIfPresent(Int.self, forKey: .administrativeSexId)
        administrativeSexCode = try values.decodeIfPresent(String.self, forKey: .administrativeSexCode)
        administrativeSexName = try values.decodeIfPresent(String.self, forKey: .administrativeSexName)
    }

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
