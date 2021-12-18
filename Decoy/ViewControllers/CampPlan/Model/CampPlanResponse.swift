//
//  CampResponse.swift
//  Decoy
//
//  Created by MAC on 18/12/21.
//

import Foundation

struct CampPlanResponse:Codable{
    let response: [CampResponse]
    let status: Int
    let message: String
}

// MARK: - Response
struct CampResponse: Codable {
    let campID, departmentID: Int
    let masState: JSONNull?
    let masDistrict: CampMasDistrict
    let masCity: CampMasCity
    let masMMU: CampMasMMU
    let campDate: Int
    let location, landMark: String
    let lattitude, longitude: Int
    let day, weeklyOff: String
    let status: JSONNull?
    let startTime, endTime: String
    let lastChangeBy: JSONNull?
    let lastChangeDate, year, month: Int
    let campDateData: String

    enum CodingKeys: String, CodingKey {
        case campID = "campId"
        case departmentID = "department_id"
        case masState, masDistrict, masCity, masMMU, campDate, location, landMark, lattitude, longitude, day, weeklyOff, status, startTime, endTime, lastChangeBy, lastChangeDate, year, month, campDateData
    }
}
// MARK: - MasCity
struct CampMasCity: Codable {
    let cityID: Int
    let cityCode: String
    let cityName: CampName
    let masDistrict: CampMasDistrict
    let status: CampStatus
    let lastChangeBy, lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityCode, cityName, masDistrict, status, lastChangeBy, lastChangeDate
    }
}

enum CampName: String, Codable {
    case raipur = "Raipur"
}

// MARK: - MasDistrict
struct CampMasDistrict: Codable {
    let districtID: Int
    let districtCode: String
    let districtName: CampName
    let masState: CampMasState
    let status: CampStatus
    let lastChangeBy: JSONNull?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case districtID = "districtId"
        case districtCode, districtName, masState, status, lastChangeBy, lastChangeDate
    }
}

enum CampDistrictCode: String, Codable {
    case raip002 = "Raip002"
}

// MARK: - MasState
struct CampMasState: Codable {
    let stateID: Int
    let stateCode: CampStateCode
    let stateName: CampStateName

    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case stateCode, stateName
    }
}

enum CampStateCode: String, Codable {
    case ch01 = "CH-01"
}

enum CampStateName: String, Codable {
    case chhattisgarh = "Chhattisgarh"
}

enum CampStatus: String, Codable {
    case y = "Y"
}

// MARK: - MasMMU
struct CampMasMMU: Codable {
    let mmuID, cityID: Int
    let lastChgBy: JSONNull?
    let lastChgDate: Int
    let mmuCode, mmuName, mmuNo: String
    let mmuTypeID, mmuVendorID: Int
    let oprationalDate: JSONNull?
    let status: CampStatus

    enum CodingKeys: String, CodingKey {
        case mmuID = "mmuId"
        case cityID = "cityId"
        case lastChgBy, lastChgDate, mmuCode, mmuName, mmuNo
        case mmuTypeID = "mmuTypeId"
        case mmuVendorID = "mmuVendorId"
        case oprationalDate, status
    }
}
