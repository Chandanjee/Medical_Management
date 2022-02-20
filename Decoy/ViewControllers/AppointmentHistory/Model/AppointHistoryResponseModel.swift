//
//  AppointHistoryResponseModel.swift
//  Decoy
//
//  Created by MAC on 29/11/21.
//

import Foundation

/*
struct AppointHistoryResponseModel: Codable {
    let response: [HistoryResponse]
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
 */
struct AppointHistoryResponseModel: Codable {
    let response : [HistoryResponse]?
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
        response = try values.decodeIfPresent([HistoryResponse].self, forKey: .response)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        versin_code = try values.decodeIfPresent(String.self, forKey: .versin_code)
        versin_app = try values.decodeIfPresent(String.self, forKey: .versin_app)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct HistoryResponse : Codable {
    let visit : HistoryVisit?
    let masCamp : HistoryMasCamp?
    let masDepartment : HistoryMasDepartment?
    let patient : HistoryPatient?

    enum CodingKeys: String, CodingKey {

        case visit = "visit"
        case masCamp = "masCamp"
        case masDepartment = "masDepartment"
        case patient = "patient"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        visit = try values.decodeIfPresent(HistoryVisit.self, forKey: .visit)
        masCamp = try values.decodeIfPresent(HistoryMasCamp.self, forKey: .masCamp)
        masDepartment = try values.decodeIfPresent(HistoryMasDepartment.self, forKey: .masDepartment)
        patient = try values.decodeIfPresent(HistoryPatient.self, forKey: .patient)
    }

}
struct HistoryVisit : Codable {
    let visitId : Int?
    let lastChgDate : Int?
    let patientId : Int?
    let priority : String?
    let camp_id : Int?
    let mmu_id : Int?
    let tokenNo : String?
    let visitDate : Int?
    let visitStatus : String?
    let visitFlag : String?
    let departmentId : Int?
    let visitDateData : String?

    enum CodingKeys: String, CodingKey {

        case visitId = "visitId"
        case lastChgDate = "lastChgDate"
        case patientId = "patientId"
        case priority = "priority"
        case camp_id = "camp_id"
        case mmu_id = "mmu_id"
        case tokenNo = "tokenNo"
        case visitDate = "visitDate"
        case visitStatus = "visitStatus"
        case visitFlag = "visitFlag"
        case departmentId = "departmentId"
        case visitDateData = "visitDateData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        visitId = try values.decodeIfPresent(Int.self, forKey: .visitId)
        lastChgDate = try values.decodeIfPresent(Int.self, forKey: .lastChgDate)
        patientId = try values.decodeIfPresent(Int.self, forKey: .patientId)
        priority = try values.decodeIfPresent(String.self, forKey: .priority)
        camp_id = try values.decodeIfPresent(Int.self, forKey: .camp_id)
        mmu_id = try values.decodeIfPresent(Int.self, forKey: .mmu_id)
        tokenNo = try values.decodeIfPresent(String.self, forKey: .tokenNo)
        visitDate = try values.decodeIfPresent(Int.self, forKey: .visitDate)
        visitStatus = try values.decodeIfPresent(String.self, forKey: .visitStatus)
        visitFlag = try values.decodeIfPresent(String.self, forKey: .visitFlag)
        departmentId = try values.decodeIfPresent(Int.self, forKey: .departmentId)
        visitDateData = try values.decodeIfPresent(String.self, forKey: .visitDateData)
    }

}
struct HistoryMasCamp : Codable {
    let campId : Int?
    let department_id : Int?
    let masState : String?
    let masDistrict : HistoryMasDistrict?
    let masCity : HistoryMasCity?
    let masMMU : HistoryMasMMU?
    let campDate : Int?
    let location : String?
    let landMark : String?
    let lattitude : Int?
    let longitude : Int?
    let day : String?
    let weeklyOff : String?
    let status : String?
    let startTime : String?
    let endTime : String?
    let lastChangeBy : String?
    let lastChangeDate : Int?
    let year : Int?
    let month : Int?
    let campDateData : String?

    enum CodingKeys: String, CodingKey {

        case campId = "campId"
        case department_id = "department_id"
        case masState = "masState"
        case masDistrict = "masDistrict"
        case masCity = "masCity"
        case masMMU = "masMMU"
        case campDate = "campDate"
        case location = "location"
        case landMark = "landMark"
        case lattitude = "lattitude"
        case longitude = "longitude"
        case day = "day"
        case weeklyOff = "weeklyOff"
        case status = "status"
        case startTime = "startTime"
        case endTime = "endTime"
        case lastChangeBy = "lastChangeBy"
        case lastChangeDate = "lastChangeDate"
        case year = "year"
        case month = "month"
        case campDateData = "campDateData"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        campId = try values.decodeIfPresent(Int.self, forKey: .campId)
        department_id = try values.decodeIfPresent(Int.self, forKey: .department_id)
        masState = try values.decodeIfPresent(String.self, forKey: .masState)
        masDistrict = try values.decodeIfPresent(HistoryMasDistrict.self, forKey: .masDistrict)
        masCity = try values.decodeIfPresent(HistoryMasCity.self, forKey: .masCity)
        masMMU = try values.decodeIfPresent(HistoryMasMMU.self, forKey: .masMMU)
        campDate = try values.decodeIfPresent(Int.self, forKey: .campDate)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        landMark = try values.decodeIfPresent(String.self, forKey: .landMark)
        lattitude = try values.decodeIfPresent(Int.self, forKey: .lattitude)
        longitude = try values.decodeIfPresent(Int.self, forKey: .longitude)
        day = try values.decodeIfPresent(String.self, forKey: .day)
        weeklyOff = try values.decodeIfPresent(String.self, forKey: .weeklyOff)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        startTime = try values.decodeIfPresent(String.self, forKey: .startTime)
        endTime = try values.decodeIfPresent(String.self, forKey: .endTime)
        lastChangeBy = try values.decodeIfPresent(String.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
        year = try values.decodeIfPresent(Int.self, forKey: .year)
        month = try values.decodeIfPresent(Int.self, forKey: .month)
        campDateData = try values.decodeIfPresent(String.self, forKey: .campDateData)
    }

}

struct HistoryMasDepartment : Codable {
    let departmentId : Int?
    let departmentCode : String?
    let departmentName : String?
    let lastChgDate : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case departmentId = "departmentId"
        case departmentCode = "departmentCode"
        case departmentName = "departmentName"
        case lastChgDate = "lastChgDate"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        departmentId = try values.decodeIfPresent(Int.self, forKey: .departmentId)
        departmentCode = try values.decodeIfPresent(String.self, forKey: .departmentCode)
        departmentName = try values.decodeIfPresent(String.self, forKey: .departmentName)
        lastChgDate = try values.decodeIfPresent(String.self, forKey: .lastChgDate)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct HistoryPatient : Codable {
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
    let administrativeSexId : HistoryAdministrativeSexId?
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
        administrativeSexId = try values.decodeIfPresent(HistoryAdministrativeSexId.self, forKey: .administrativeSexId)
        religionId = try values.decodeIfPresent(String.self, forKey: .religionId)
        regNo = try values.decodeIfPresent(String.self, forKey: .regNo)
        stateId = try values.decodeIfPresent(String.self, forKey: .stateId)
        uhidNo = try values.decodeIfPresent(String.self, forKey: .uhidNo)
        age = try values.decodeIfPresent(Int.self, forKey: .age)
    }

}
struct HistoryMasCity : Codable {
    let cityId : Int?
    let cityCode : String?
    let cityName : String?
    let masDistrict : HistoryMasDistrict?
    let status : String?
    let lastChangeBy : Int?
    let lastChangeDate : Int?

    enum CodingKeys: String, CodingKey {

        case cityId = "cityId"
        case cityCode = "cityCode"
        case cityName = "cityName"
        case masDistrict = "masDistrict"
        case status = "status"
        case lastChangeBy = "lastChangeBy"
        case lastChangeDate = "lastChangeDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        cityCode = try values.decodeIfPresent(String.self, forKey: .cityCode)
        cityName = try values.decodeIfPresent(String.self, forKey: .cityName)
        masDistrict = try values.decodeIfPresent(HistoryMasDistrict.self, forKey: .masDistrict)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(Int.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}

struct HistoryMasMMU : Codable {
    let mmuId : Int?
    let cityId : Int?
    let lastChgBy : Int?
    let lastChgDate : Int?
    let mmuCode : String?
    let mmuName : String?
    let mmuNo : String?
    let mmuTypeId : Int?
    let mmuVendorId : Int?
    let oprationalDate : Int?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case mmuId = "mmuId"
        case cityId = "cityId"
        case lastChgBy = "lastChgBy"
        case lastChgDate = "lastChgDate"
        case mmuCode = "mmuCode"
        case mmuName = "mmuName"
        case mmuNo = "mmuNo"
        case mmuTypeId = "mmuTypeId"
        case mmuVendorId = "mmuVendorId"
        case oprationalDate = "oprationalDate"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        mmuId = try values.decodeIfPresent(Int.self, forKey: .mmuId)
        cityId = try values.decodeIfPresent(Int.self, forKey: .cityId)
        lastChgBy = try values.decodeIfPresent(Int.self, forKey: .lastChgBy)
        lastChgDate = try values.decodeIfPresent(Int.self, forKey: .lastChgDate)
        mmuCode = try values.decodeIfPresent(String.self, forKey: .mmuCode)
        mmuName = try values.decodeIfPresent(String.self, forKey: .mmuName)
        mmuNo = try values.decodeIfPresent(String.self, forKey: .mmuNo)
        mmuTypeId = try values.decodeIfPresent(Int.self, forKey: .mmuTypeId)
        mmuVendorId = try values.decodeIfPresent(Int.self, forKey: .mmuVendorId)
        oprationalDate = try values.decodeIfPresent(Int.self, forKey: .oprationalDate)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
struct HistoryMasDistrict : Codable {
    let districtId : Int?
    let districtCode : String?
    let districtName : String?
    let masState : HistoryMasState?
    let status : String?
    let lastChangeBy : String?
    let lastChangeDate : Int?

    enum CodingKeys: String, CodingKey {

        case districtId = "districtId"
        case districtCode = "districtCode"
        case districtName = "districtName"
        case masState = "masState"
        case status = "status"
        case lastChangeBy = "lastChangeBy"
        case lastChangeDate = "lastChangeDate"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        districtId = try values.decodeIfPresent(Int.self, forKey: .districtId)
        districtCode = try values.decodeIfPresent(String.self, forKey: .districtCode)
        districtName = try values.decodeIfPresent(String.self, forKey: .districtName)
        masState = try values.decodeIfPresent(HistoryMasState.self, forKey: .masState)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(String.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}
struct HistoryMasState : Codable {
    let stateId : Int?
    let stateCode : String?
    let stateName : String?

    enum CodingKeys: String, CodingKey {

        case stateId = "stateId"
        case stateCode = "stateCode"
        case stateName = "stateName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        stateId = try values.decodeIfPresent(Int.self, forKey: .stateId)
        stateCode = try values.decodeIfPresent(String.self, forKey: .stateCode)
        stateName = try values.decodeIfPresent(String.self, forKey: .stateName)
    }

}
struct HistoryAdministrativeSexId : Codable {
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
typealias  totalHistoryResponse = [HistoryResponse]
