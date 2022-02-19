//
//  OPDResponseModel.swift
//  Decoy
//
//  Created by MAC on 03/12/21.
//

import Foundation
struct OPDResponseModel:Codable {
    let response: [OPDResponse]
    let status: Int
//    let message: String
    let versinCode, versinApp, message: String

        enum CodingKeys: String, CodingKey {
            case response, status
            case versinCode = "versin_code"
            case versinApp = "versin_app"
            case message
        }
}

// MARK: - Response
struct OPDResponse: Codable {
    let visit: OPDVisit
    let masCamp: OPDMasCamp
    let masDepartment: OPDMasDepartment
    let patient: OPDPatient
}

// MARK: - MasCamp
struct OPDMasCamp: Codable {
    let campID, departmentID: Int
    let masState: JSONNull?
    let masDistrict: OPDMasDistrict
    let masCity: OPDMasCity
    let masMMU: OPDMasMMU
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
struct OPDMasCity: Codable {
    let cityID: Int
    let cityCode, cityName: String
    let masDistrict: OPDMasDistrict
    let status: String
    let lastChangeBy, lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityCode, cityName, masDistrict, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasDistrict
struct OPDMasDistrict: Codable {
    let districtID: Int
    let districtCode, districtName: String
    let masState: OPDMasState
    let status: String
    let lastChangeBy: JSONNull?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case districtID = "districtId"
        case districtCode, districtName, masState, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasState
struct OPDMasState: Codable {
    let stateID: Int
    let stateCode, stateName: String

    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case stateCode, stateName
    }
}

// MARK: - MasMMU
struct OPDMasMMU: Codable {
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
struct OPDMasDepartment: Codable {
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
struct OPDPatient: Codable {
    let patientID: Int
    let address: String
    let cityID, dateOfBirth, districtID: Int
    let formSubmitted: JSONNull?
    let identificationNo: String
    let laborRegistered, lastChgDate: JSONNull?
    let mobileNumber, occuption, patientName, patientType: String
    let loginPwd: String
    let pincode, campID: Int
    let administrativeSexID: OPDAdministrativeSexID
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
struct OPDAdministrativeSexID: Codable {
    let administrativeSexID: Int
    let administrativeSexCode, administrativeSexName: String

    enum CodingKeys: String, CodingKey {
        case administrativeSexID = "administrativeSexId"
        case administrativeSexCode, administrativeSexName
    }
}

// MARK: - Visit
struct OPDVisit: Codable {
    let visitID, lastChgDate, patientID: Int
    let priority: JSONNull?
    let campID, mmuID: Int
    let tokenNo: JSONNull?
    let visitDate: Int
    let visitStatus, visitFlag: String
    let departmentID: Int

    enum CodingKeys: String, CodingKey {
        case visitID = "visitId"
        case lastChgDate
        case patientID = "patientId"
        case priority
        case campID = "camp_id"
        case mmuID = "mmu_id"
        case tokenNo, visitDate, visitStatus, visitFlag
        case departmentID = "departmentId"
    }
}
