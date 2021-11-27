//
//  AppointmentResponseModel.swift
//  Decoy
//
//  Created by MAC on 27/11/21.
//

import Foundation

struct AppointmentResponseModel:Codable{
    let response: [ResponseAppointment]
    let status: Int
    let message: String
}

// MARK: - Response
struct ResponseAppointment: Codable {
    let campID, departmentID: Int
    let masState: JSONNull?
    let masDistrict: MasDistrict
    let masCity: MasCityAppoint
    let masMMU: MasMMUAppoint
    let campDate: Int
    let location, landMark: String
    let lattitude, longitude: Int
    let day, weeklyOff: String
    let status: JSONNull?
    let startTime, endTime: String
    let lastChangeBy: JSONNull?
    let lastChangeDate, year, month: Int

    enum CodingKeys: String, CodingKey {
        case campID = "campId"
        case departmentID = "department_id"
        case masState, masDistrict, masCity, masMMU, campDate, location, landMark, lattitude, longitude, day, weeklyOff, status, startTime, endTime, lastChangeBy, lastChangeDate, year, month
    }
}

// MARK: - MasCity
struct MasCityAppoint: Codable {
    let cityID: Int
    let cityCode, cityName: String
    let masDistrict: MasDistrict
    let status: String
    let lastChangeBy: Int?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityCode, cityName, masDistrict, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasDistrict
struct MasDistrict: Codable {
    let districtID: Int
    let districtCode, districtName: String
    let masState: MasState
    let status: Status
    let lastChangeBy: Int?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case districtID = "districtId"
        case districtCode, districtName, masState, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasState
struct MasState: Codable {
    let stateID: Int
    let stateCode: StateCode
    let stateName: StateName

    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case stateCode, stateName
    }
}

enum StateCode: String, Codable {
    case ch01 = "CH-01"
}

enum StateName: String, Codable {
    case chhattisgarh = "Chhattisgarh"
}

enum Status: String, Codable {
    case y = "Y"
}

// MARK: - MasMMU
struct MasMMUAppoint: Codable {
    let mmuID, cityID: Int
    let lastChgBy: Int?
    let lastChgDate: Int
    let mmuCode, mmuName, mmuNo: String
    let mmuTypeID, mmuVendorID: Int
    let oprationalDate: Int?
    let status: String

    enum CodingKeys: String, CodingKey {
        case mmuID = "mmuId"
        case cityID = "cityId"
        case lastChgBy, lastChgDate, mmuCode, mmuName, mmuNo
        case mmuTypeID = "mmuTypeId"
        case mmuVendorID = "mmuVendorId"
        case oprationalDate, status
    }
}


typealias  totalAppointmentCity = [ResponseAppointment]
