//
//  CampResponse.swift
//  Decoy
//
//  Created by MAC on 18/12/21.
//

import Foundation

/*
struct CampPlanResponse:Codable{
    let response: [CampResponse]
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
*/
struct CampPlanResponse:Codable{
    let response : [CampResponse]?
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
        response = try values.decodeIfPresent([CampResponse].self, forKey: .response)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        versin_code = try values.decodeIfPresent(String.self, forKey: .versin_code)
        versin_app = try values.decodeIfPresent(String.self, forKey: .versin_app)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}

struct CampResponse: Codable {
    let campId : Int?
    let department_id : Int?
    let masState : String?
    let masDistrict : MasDistrict?
    let masCity : CampMasCity?
    let masMMU : CampMasMMU?
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
        masDistrict = try values.decodeIfPresent(MasDistrict.self, forKey: .masDistrict)
        masCity = try values.decodeIfPresent(CampMasCity.self, forKey: .masCity)
        masMMU = try values.decodeIfPresent(CampMasMMU.self, forKey: .masMMU)
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

struct CampMasCity: Codable {
    let cityId : Int?
    let cityCode : String?
    let cityName : String?
    let masDistrict : MasDistrict?
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
        masDistrict = try values.decodeIfPresent(MasDistrict.self, forKey: .masDistrict)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(Int.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}

struct CampMasDistrict: Codable {
    let districtId : Int?
    let districtCode : String?
    let districtName : String?
    let masState : MasState?
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
        masState = try values.decodeIfPresent(MasState.self, forKey: .masState)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(String.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}
struct CampMasState: Codable {
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
struct CampMasMMU: Codable {
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
