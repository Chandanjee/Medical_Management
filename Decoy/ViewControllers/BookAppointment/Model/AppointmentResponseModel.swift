//
//  AppointmentResponseModel.swift
//  Decoy
//
//  Created by MAC on 27/11/21.
//

import Foundation
import SwiftyJSON


struct AppointmentResponseModel:Codable{
    let response: [ResponseAppointment]
    let status: Int
    let message: String
}

// MARK: - Response
struct ResponseAppointment: Codable {
    let campID, departmentID: Int
    let masState: JSONNull?
    let masDistrict: MasDistrictAppoint
    let masCity: MasCityAppoint
    let masMMU: MasMMUAppoint
    let campDate: Int
    let location, landMark: String
    let lattitude, longitude: Int
    let day: String?
    let weeklyOff: String?
    let status: JSONNull?
    let startTime, endTime: String
    let lastChangeBy: JSONNull?
    let lastChangeDate, year, month: Int
    let campDateData: JSONNull?

    enum CodingKeys: String, CodingKey {
        case campID = "campId"
        case departmentID = "department_id"
        case masState, masDistrict, masCity, masMMU, campDate, location, landMark, lattitude, longitude, day, weeklyOff, status, startTime, endTime, lastChangeBy, lastChangeDate, year, month, campDateData
    }
}

// MARK: - MasCity
struct MasCityAppoint: Codable {
    let cityID: Int
    let cityCode, cityName: String
    let masDistrict: MasDistrictAppoint
    let status: String?
    let lastChangeBy: Int?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityCode, cityName, masDistrict, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasDistrict
struct MasDistrictAppoint: Codable {
    let districtID: Int
    let districtCode: String?
    let districtName: String?
    let masState: MasStateAppoint
    let status: String?
    let lastChangeBy: Int?
    let lastChangeDate: Int

    enum CodingKeys: String, CodingKey {
        case districtID = "districtId"
        case districtCode, districtName, masState, status, lastChangeBy, lastChangeDate
    }
}

// MARK: - MasState
struct MasStateAppoint: Codable {
    let stateID: Int
    let stateCode: String?
    let stateName: String?

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
    let status: String?

    enum CodingKeys: String, CodingKey {
        case mmuID = "mmuId"
        case cityID = "cityId"
        case lastChgBy, lastChgDate, mmuCode, mmuName, mmuNo
        case mmuTypeID = "mmuTypeId"
        case mmuVendorID = "mmuVendorId"
        case oprationalDate, status
    }
}

/*
struct AppointmentResponseModels:Codable{
    let response : [ResponseAppointment]?
    let status : Int?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case response = "response"
        case status = "status"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        response = try values.decodeIfPresent([ResponseAppointment].self, forKey: .response)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}
struct ResponseAppointment: Codable {
    let campId : Int?
    let department_id : Int?
    let masState : String?
    let masDistrict : MasDistrictAppointment?
    let masCity : MasCityAppointment?
    let masMMU : MasMMUAppointment?
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
        masDistrict = try values.decodeIfPresent(MasDistrictAppointment.self, forKey: .masDistrict)
        masCity = try values.decodeIfPresent(MasCityAppointment.self, forKey: .masCity)
        masMMU = try values.decodeIfPresent(MasMMUAppointment.self, forKey: .masMMU)
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

struct MasCityAppointment: Codable {
    let cityId : Int?
    let cityCode : String?
    let cityName : String?
    let masDistrict : MasDistrictAppointment?
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
        masDistrict = try values.decodeIfPresent(MasDistrictAppointment.self, forKey: .masDistrict)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(Int.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}
struct MasDistrictAppointment: Codable {
    let districtId : Int?
    let districtCode : String?
    let districtName : String?
    let masState : MasStateAppointment?
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
        masState = try values.decodeIfPresent(MasStateAppointment.self, forKey: .masState)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        lastChangeBy = try values.decodeIfPresent(String.self, forKey: .lastChangeBy)
        lastChangeDate = try values.decodeIfPresent(Int.self, forKey: .lastChangeDate)
    }

}

struct MasStateAppointment: Codable {
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
struct MasMMUAppointment: Codable {
    let mmuId : Int?
    let cityId : Int?
    let lastChgBy : String?
    let lastChgDate : Int?
    let mmuCode : String?
    let mmuName : String?
    let mmuNo : String?
    let mmuTypeId : Int?
    let mmuVendorId : Int?
    let oprationalDate : String?
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
        lastChgBy = try values.decodeIfPresent(String.self, forKey: .lastChgBy)
        lastChgDate = try values.decodeIfPresent(Int.self, forKey: .lastChgDate)
        mmuCode = try values.decodeIfPresent(String.self, forKey: .mmuCode)
        mmuName = try values.decodeIfPresent(String.self, forKey: .mmuName)
        mmuNo = try values.decodeIfPresent(String.self, forKey: .mmuNo)
        mmuTypeId = try values.decodeIfPresent(Int.self, forKey: .mmuTypeId)
        mmuVendorId = try values.decodeIfPresent(Int.self, forKey: .mmuVendorId)
        oprationalDate = try values.decodeIfPresent(String.self, forKey: .oprationalDate)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
*/
/*
class AppointmentResponseModels:NSObject, NSCoding{
    
    var message : String!
    var response : [ResponseAppointment]!
    var status : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        message = json["message"].stringValue
        response = [ResponseAppointment]()
        let responseArray = json["response"].arrayValue
        for responseJson in responseArray{
            let value = ResponseAppointment(fromJson: responseJson)
            response.append(value)
        }
        status = json["status"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if message != nil{
            dictionary["message"] = message
        }
        if response != nil{
            var dictionaryElements = [[String:Any]]()
            for responseElement in response {
                dictionaryElements.append(responseElement.toDictionary())
            }
            dictionary["response"] = dictionaryElements
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         message = aDecoder.decodeObject(forKey: "message") as? String
         response = aDecoder.decodeObject(forKey: "response") as? [ResponseAppointment]
         status = aDecoder.decodeObject(forKey: "status") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if response != nil{
            aCoder.encode(response, forKey: "response")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class ResponseAppointment: NSObject, NSCoding{
    
    var campDate : Int!
    var campDateData : AnyObject!
    var campId : Int!
    var day : String!
    var departmentId : Int!
    var endTime : String!
    var landMark : String!
    var lastChangeBy : AnyObject!
    var lastChangeDate : Int!
    var lattitude : Int!
    var location : String!
    var longitude : Int!
    var masCity : MasCityAppointment!
    var masDistrict : MasDistrictAppointment!
    var masMMU : MasMMUAppointment!
    var masState : AnyObject!
    var month : Int!
    var startTime : String!
    var status : AnyObject!
    var weeklyOff : String!
    var year : Int!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        campDate = json["campDate"].intValue
        campDateData = json["campDateData"].stringValue as AnyObject
        campId = json["campId"].intValue
        day = json["day"].stringValue
        departmentId = json["department_id"].intValue
        endTime = json["endTime"].stringValue
        landMark = json["landMark"].stringValue
        lastChangeBy = json["lastChangeBy"].stringValue as AnyObject
        lastChangeDate = json["lastChangeDate"].intValue
        lattitude = json["lattitude"].intValue
        location = json["location"].stringValue
        longitude = json["longitude"].intValue
        let masCityJson = json["masCity"]
        if !masCityJson.isEmpty{
            masCity = MasCityAppointment(fromJson: masCityJson)
        }
        let masDistrictJson = json["masDistrict"]
        if !masDistrictJson.isEmpty{
            masDistrict = MasDistrictAppointment(fromJson: masDistrictJson)
        }
        let masMMUJson = json["masMMU"]
        if !masMMUJson.isEmpty{
            masMMU = MasMMUAppointment(fromJson: masMMUJson)
        }
        masState = json["masState"].stringValue as AnyObject
        month = json["month"].intValue
        startTime = json["startTime"].stringValue
        status = json["status"].stringValue as AnyObject
        weeklyOff = json["weeklyOff"].stringValue
        year = json["year"].intValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if campDate != nil{
            dictionary["campDate"] = campDate
        }
        if campDateData != nil{
            dictionary["campDateData"] = campDateData
        }
        if campId != nil{
            dictionary["campId"] = campId
        }
        if day != nil{
            dictionary["day"] = day
        }
        if departmentId != nil{
            dictionary["department_id"] = departmentId
        }
        if endTime != nil{
            dictionary["endTime"] = endTime
        }
        if landMark != nil{
            dictionary["landMark"] = landMark
        }
        if lastChangeBy != nil{
            dictionary["lastChangeBy"] = lastChangeBy
        }
        if lastChangeDate != nil{
            dictionary["lastChangeDate"] = lastChangeDate
        }
        if lattitude != nil{
            dictionary["lattitude"] = lattitude
        }
        if location != nil{
            dictionary["location"] = location
        }
        if longitude != nil{
            dictionary["longitude"] = longitude
        }
        if masCity != nil{
            dictionary["masCity"] = masCity.toDictionary()
        }
        if masDistrict != nil{
            dictionary["masDistrict"] = masDistrict.toDictionary()
        }
        if masMMU != nil{
            dictionary["masMMU"] = masMMU.toDictionary()
        }
        if masState != nil{
            dictionary["masState"] = masState
        }
        if month != nil{
            dictionary["month"] = month
        }
        if startTime != nil{
            dictionary["startTime"] = startTime
        }
        if status != nil{
            dictionary["status"] = status
        }
        if weeklyOff != nil{
            dictionary["weeklyOff"] = weeklyOff
        }
        if year != nil{
            dictionary["year"] = year
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         campDate = aDecoder.decodeObject(forKey: "campDate") as? Int
         campDateData = aDecoder.decodeObject(forKey: "campDateData") as? AnyObject
         campId = aDecoder.decodeObject(forKey: "campId") as? Int
         day = aDecoder.decodeObject(forKey: "day") as? String
         departmentId = aDecoder.decodeObject(forKey: "department_id") as? Int
         endTime = aDecoder.decodeObject(forKey: "endTime") as? String
         landMark = aDecoder.decodeObject(forKey: "landMark") as? String
         lastChangeBy = aDecoder.decodeObject(forKey: "lastChangeBy") as? AnyObject
         lastChangeDate = aDecoder.decodeObject(forKey: "lastChangeDate") as? Int
         lattitude = aDecoder.decodeObject(forKey: "lattitude") as? Int
         location = aDecoder.decodeObject(forKey: "location") as? String
         longitude = aDecoder.decodeObject(forKey: "longitude") as? Int
         masCity = aDecoder.decodeObject(forKey: "masCity") as? MasCityAppointment
         masDistrict = aDecoder.decodeObject(forKey: "masDistrict") as? MasDistrictAppointment
         masMMU = aDecoder.decodeObject(forKey: "masMMU") as? MasMMUAppointment
         masState = aDecoder.decodeObject(forKey: "masState") as? AnyObject
         month = aDecoder.decodeObject(forKey: "month") as? Int
         startTime = aDecoder.decodeObject(forKey: "startTime") as? String
         status = aDecoder.decodeObject(forKey: "status") as? AnyObject
         weeklyOff = aDecoder.decodeObject(forKey: "weeklyOff") as? String
         year = aDecoder.decodeObject(forKey: "year") as? Int

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if campDate != nil{
            aCoder.encode(campDate, forKey: "campDate")
        }
        if campDateData != nil{
            aCoder.encode(campDateData, forKey: "campDateData")
        }
        if campId != nil{
            aCoder.encode(campId, forKey: "campId")
        }
        if day != nil{
            aCoder.encode(day, forKey: "day")
        }
        if departmentId != nil{
            aCoder.encode(departmentId, forKey: "department_id")
        }
        if endTime != nil{
            aCoder.encode(endTime, forKey: "endTime")
        }
        if landMark != nil{
            aCoder.encode(landMark, forKey: "landMark")
        }
        if lastChangeBy != nil{
            aCoder.encode(lastChangeBy, forKey: "lastChangeBy")
        }
        if lastChangeDate != nil{
            aCoder.encode(lastChangeDate, forKey: "lastChangeDate")
        }
        if lattitude != nil{
            aCoder.encode(lattitude, forKey: "lattitude")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if longitude != nil{
            aCoder.encode(longitude, forKey: "longitude")
        }
        if masCity != nil{
            aCoder.encode(masCity, forKey: "masCity")
        }
        if masDistrict != nil{
            aCoder.encode(masDistrict, forKey: "masDistrict")
        }
        if masMMU != nil{
            aCoder.encode(masMMU, forKey: "masMMU")
        }
        if masState != nil{
            aCoder.encode(masState, forKey: "masState")
        }
        if month != nil{
            aCoder.encode(month, forKey: "month")
        }
        if startTime != nil{
            aCoder.encode(startTime, forKey: "startTime")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if weeklyOff != nil{
            aCoder.encode(weeklyOff, forKey: "weeklyOff")
        }
        if year != nil{
            aCoder.encode(year, forKey: "year")
        }

    }

}
class MasMMUAppointment: NSObject, NSCoding{
    
    var cityId : Int!
    var lastChgBy : AnyObject!
    var lastChgDate : Int!
    var mmuCode : String!
    var mmuId : Int!
    var mmuName : String!
    var mmuNo : String!
    var mmuTypeId : Int!
    var mmuVendorId : Int!
    var oprationalDate : AnyObject!
    var status : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        cityId = json["cityId"].intValue
        lastChgBy = json["lastChgBy"].stringValue as AnyObject
        lastChgDate = json["lastChgDate"].intValue
        mmuCode = json["mmuCode"].stringValue
        mmuId = json["mmuId"].intValue
        mmuName = json["mmuName"].stringValue
        mmuNo = json["mmuNo"].stringValue
        mmuTypeId = json["mmuTypeId"].intValue
        mmuVendorId = json["mmuVendorId"].intValue
        oprationalDate = json["oprationalDate"].stringValue as AnyObject
        status = json["status"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cityId != nil{
            dictionary["cityId"] = cityId
        }
        if lastChgBy != nil{
            dictionary["lastChgBy"] = lastChgBy
        }
        if lastChgDate != nil{
            dictionary["lastChgDate"] = lastChgDate
        }
        if mmuCode != nil{
            dictionary["mmuCode"] = mmuCode
        }
        if mmuId != nil{
            dictionary["mmuId"] = mmuId
        }
        if mmuName != nil{
            dictionary["mmuName"] = mmuName
        }
        if mmuNo != nil{
            dictionary["mmuNo"] = mmuNo
        }
        if mmuTypeId != nil{
            dictionary["mmuTypeId"] = mmuTypeId
        }
        if mmuVendorId != nil{
            dictionary["mmuVendorId"] = mmuVendorId
        }
        if oprationalDate != nil{
            dictionary["oprationalDate"] = oprationalDate
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         cityId = aDecoder.decodeObject(forKey: "cityId") as? Int
         lastChgBy = aDecoder.decodeObject(forKey: "lastChgBy") as? AnyObject
         lastChgDate = aDecoder.decodeObject(forKey: "lastChgDate") as? Int
         mmuCode = aDecoder.decodeObject(forKey: "mmuCode") as? String
         mmuId = aDecoder.decodeObject(forKey: "mmuId") as? Int
         mmuName = aDecoder.decodeObject(forKey: "mmuName") as? String
         mmuNo = aDecoder.decodeObject(forKey: "mmuNo") as? String
         mmuTypeId = aDecoder.decodeObject(forKey: "mmuTypeId") as? Int
         mmuVendorId = aDecoder.decodeObject(forKey: "mmuVendorId") as? Int
         oprationalDate = aDecoder.decodeObject(forKey: "oprationalDate") as? AnyObject
         status = aDecoder.decodeObject(forKey: "status") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if cityId != nil{
            aCoder.encode(cityId, forKey: "cityId")
        }
        if lastChgBy != nil{
            aCoder.encode(lastChgBy, forKey: "lastChgBy")
        }
        if lastChgDate != nil{
            aCoder.encode(lastChgDate, forKey: "lastChgDate")
        }
        if mmuCode != nil{
            aCoder.encode(mmuCode, forKey: "mmuCode")
        }
        if mmuId != nil{
            aCoder.encode(mmuId, forKey: "mmuId")
        }
        if mmuName != nil{
            aCoder.encode(mmuName, forKey: "mmuName")
        }
        if mmuNo != nil{
            aCoder.encode(mmuNo, forKey: "mmuNo")
        }
        if mmuTypeId != nil{
            aCoder.encode(mmuTypeId, forKey: "mmuTypeId")
        }
        if mmuVendorId != nil{
            aCoder.encode(mmuVendorId, forKey: "mmuVendorId")
        }
        if oprationalDate != nil{
            aCoder.encode(oprationalDate, forKey: "oprationalDate")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class MasCityAppointment: NSObject, NSCoding{
    
    var cityCode : String!
    var cityId : Int!
    var cityName : String!
    var lastChangeBy : Int!
    var lastChangeDate : Int!
    var masDistrict : MasDistrictAppointment!
    var status : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        cityCode = json["cityCode"].stringValue
        cityId = json["cityId"].intValue
        cityName = json["cityName"].stringValue
        lastChangeBy = json["lastChangeBy"].intValue
        lastChangeDate = json["lastChangeDate"].intValue
        let masDistrictJson = json["masDistrict"]
        if !masDistrictJson.isEmpty{
            masDistrict = MasDistrictAppointment(fromJson: masDistrictJson)
        }
        status = json["status"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cityCode != nil{
            dictionary["cityCode"] = cityCode
        }
        if cityId != nil{
            dictionary["cityId"] = cityId
        }
        if cityName != nil{
            dictionary["cityName"] = cityName
        }
        if lastChangeBy != nil{
            dictionary["lastChangeBy"] = lastChangeBy
        }
        if lastChangeDate != nil{
            dictionary["lastChangeDate"] = lastChangeDate
        }
        if masDistrict != nil{
            dictionary["masDistrict"] = masDistrict.toDictionary()
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         cityCode = aDecoder.decodeObject(forKey: "cityCode") as? String
         cityId = aDecoder.decodeObject(forKey: "cityId") as? Int
         cityName = aDecoder.decodeObject(forKey: "cityName") as? String
         lastChangeBy = aDecoder.decodeObject(forKey: "lastChangeBy") as? Int
         lastChangeDate = aDecoder.decodeObject(forKey: "lastChangeDate") as? Int
         masDistrict = aDecoder.decodeObject(forKey: "masDistrict") as? MasDistrictAppointment
         status = aDecoder.decodeObject(forKey: "status") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if cityCode != nil{
            aCoder.encode(cityCode, forKey: "cityCode")
        }
        if cityId != nil{
            aCoder.encode(cityId, forKey: "cityId")
        }
        if cityName != nil{
            aCoder.encode(cityName, forKey: "cityName")
        }
        if lastChangeBy != nil{
            aCoder.encode(lastChangeBy, forKey: "lastChangeBy")
        }
        if lastChangeDate != nil{
            aCoder.encode(lastChangeDate, forKey: "lastChangeDate")
        }
        if masDistrict != nil{
            aCoder.encode(masDistrict, forKey: "masDistrict")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class MasDistrictAppointment:  NSObject, NSCoding{
    
    var districtCode : String!
    var districtId : Int!
    var districtName : String!
    var lastChangeBy : AnyObject!
    var lastChangeDate : Int!
    var masState : MasStateAppointment!
    var status : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        districtCode = json["districtCode"].stringValue
        districtId = json["districtId"].intValue
        districtName = json["districtName"].stringValue
        lastChangeBy = json["lastChangeBy"].stringValue as AnyObject
        lastChangeDate = json["lastChangeDate"].intValue
        let masStateJson = json["masState"]
        if !masStateJson.isEmpty{
            masState = MasStateAppointment(fromJson: masStateJson)
        }
        status = json["status"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if districtCode != nil{
            dictionary["districtCode"] = districtCode
        }
        if districtId != nil{
            dictionary["districtId"] = districtId
        }
        if districtName != nil{
            dictionary["districtName"] = districtName
        }
        if lastChangeBy != nil{
            dictionary["lastChangeBy"] = lastChangeBy
        }
        if lastChangeDate != nil{
            dictionary["lastChangeDate"] = lastChangeDate
        }
        if masState != nil{
            dictionary["masState"] = masState.toDictionary()
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         districtCode = aDecoder.decodeObject(forKey: "districtCode") as? String
         districtId = aDecoder.decodeObject(forKey: "districtId") as? Int
         districtName = aDecoder.decodeObject(forKey: "districtName") as? String
         lastChangeBy = aDecoder.decodeObject(forKey: "lastChangeBy") as? AnyObject
         lastChangeDate = aDecoder.decodeObject(forKey: "lastChangeDate") as? Int
         masState = aDecoder.decodeObject(forKey: "masState") as? MasStateAppointment
         status = aDecoder.decodeObject(forKey: "status") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if districtCode != nil{
            aCoder.encode(districtCode, forKey: "districtCode")
        }
        if districtId != nil{
            aCoder.encode(districtId, forKey: "districtId")
        }
        if districtName != nil{
            aCoder.encode(districtName, forKey: "districtName")
        }
        if lastChangeBy != nil{
            aCoder.encode(lastChangeBy, forKey: "lastChangeBy")
        }
        if lastChangeDate != nil{
            aCoder.encode(lastChangeDate, forKey: "lastChangeDate")
        }
        if masState != nil{
            aCoder.encode(masState, forKey: "masState")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }

    }

}
class MasStateAppointment:NSObject, NSCoding{
    
    var stateCode : String!
    var stateId : Int!
    var stateName : String!


    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        stateCode = json["stateCode"].stringValue
        stateId = json["stateId"].intValue
        stateName = json["stateName"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if stateCode != nil{
            dictionary["stateCode"] = stateCode
        }
        if stateId != nil{
            dictionary["stateId"] = stateId
        }
        if stateName != nil{
            dictionary["stateName"] = stateName
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         stateCode = aDecoder.decodeObject(forKey: "stateCode") as? String
         stateId = aDecoder.decodeObject(forKey: "stateId") as? Int
         stateName = aDecoder.decodeObject(forKey: "stateName") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if stateCode != nil{
            aCoder.encode(stateCode, forKey: "stateCode")
        }
        if stateId != nil{
            aCoder.encode(stateId, forKey: "stateId")
        }
        if stateName != nil{
            aCoder.encode(stateName, forKey: "stateName")
        }

    }

}
*/
typealias  totalAppointmentCity = [ResponseAppointment]
