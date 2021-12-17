//
//  AppointHistoryResponseModel.swift
//  Decoy
//
//  Created by MAC on 29/11/21.
//

import Foundation


struct AppointHistoryResponseModel: Codable {
    let response: [HistoryResponse]
    let status: Int
    let message: String
}

// MARK: - Response
struct HistoryResponse: Codable {
    let visit: HistoryVisit
    let masCamp: HistoryMasCamp
    let masDepartment: HistoryMasDepartment
    let patient: HistoryPatient
}

// MARK: - MasCamp
struct HistoryMasCamp: Codable {
    let campID, departmentID: Int
    let masState: JSONNull?
    let masDistrict: HistoryMasDistrict
    let masCity: HistoryMasCity
    let masMMU: HistoryMasMMU
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
struct HistoryMasCity: Codable {
    let cityID: Int
    let cityCode, cityName: String
    let masDistrict: HistoryMasDistrict
    let status: String
    let lastChangeBy: Int?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityCode, cityName, masDistrict, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasDistrict
struct HistoryMasDistrict: Codable {
    let districtID: Int
    let districtCode, districtName: String
    let masState: HistoryMasState
//    let status: HistoryStatus
    let status: String
    let lastChangeBy: JSONNull?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case districtID = "districtId"
        case districtCode, districtName, masState, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasState
struct HistoryMasState: Codable {
    let stateID: Int
//    let stateCode: HistoryStateCode
//    let stateName: HistoryStateName
    let stateCode, stateName: String


    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case stateCode, stateName
    }
}

enum HistoryStateCode: String, Codable {
    case ch01 = "CH-01"
}

enum HistoryStateName: String, Codable {
    case chhattisgarh = "Chhattisgarh"
}

enum HistoryStatus: String, Codable {
    case y = "Y"
}

// MARK: - MasMMU
struct HistoryMasMMU: Codable {
    let mmuID, cityID: Int
    let lastChgBy: JSONNull?
    let lastChgDate: Int
    let mmuCode, mmuName, mmuNo: String
    let mmuTypeID, mmuVendorID: Int
    let oprationalDate: JSONNull?
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

// MARK: - MasDepartment
struct HistoryMasDepartment: Codable {
    let departmentID: Int
    let departmentCode, departmentName: String
    let lastChgDate: JSONNull?
    let status: String

    enum CodingKeys: String, CodingKey {
        case departmentID = "departmentId"
        case departmentCode, departmentName, lastChgDate, status
    }
}

// MARK: - Patient
struct HistoryPatient: Codable {
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
    let campID: Int
    let administrativeSexID: HistoryAdministrativeSexID
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
struct HistoryAdministrativeSexID: Codable {
    let administrativeSexID: Int
    let administrativeSexCode, administrativeSexName: String

    enum CodingKeys: String, CodingKey {
        case administrativeSexID = "administrativeSexId"
        case administrativeSexCode, administrativeSexName
    }
}

// MARK: - Visit
struct HistoryVisit: Codable {
    let visitID, lastChgDate, patientID: Int
    let priority: JSONNull?
    let campID, mmuID: Int
    let tokenNo: JSONNull?
    let visitDate: Int
    let visitStatus, visitFlag: String
    let departmentID: Int
    let visitDateData: String

    enum CodingKeys: String, CodingKey {
        case visitID = "visitId"
        case lastChgDate
        case patientID = "patientId"
        case priority
        case campID = "camp_id"
        case mmuID = "mmu_id"
        case tokenNo, visitDate, visitStatus, visitFlag
        case departmentID = "departmentId"
        case visitDateData
    }
}
typealias  totalHistoryResponse = [HistoryResponse]
