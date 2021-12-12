//
//  CollectionData.swift
//  Decoy
//
//  Created by MAC on 24/10/21.
//

import Foundation

class EntryData {
    let image : String
    let title : String
    init(image : String, title : String) {
        self.image = image
        self.title = title
    }
}

class CollectionData {
    let datass = [
       
        EntryData(image: "appointment", title: "Book Appointment"),
        EntryData(image: "status", title: "Appointment Status"),
        EntryData(image: "camp", title: "Lab Result"),
        EntryData(image: "docIcons", title: "Camp Plan"),
        EntryData(image: "notification", title: "Notification"),
        EntryData(image: "family", title: "Add Family Member"),
        EntryData(image: "opd", title: "OPD History"),

    ]
}


class OfficialCollection{
    let AnalyticalReport = [
        EntryData(image: "appointment", title: "MMU Register"),
        EntryData(image: "appointment", title: "OPD Reports"),
        EntryData(image: "appointment", title: "Monthly Camp Reports"),
        EntryData(image: "appointment", title: "Daily MMU Register"),
        EntryData(image: "appointment", title: "Indent Register"),
        EntryData(image: "appointment", title: "Medicine Issue Register"),
        EntryData(image: "appointment", title: "Stock Status Reports"),
        EntryData(image: "appointment", title: "Opening Balance Register"),
        EntryData(image: "appointment", title: "Daily Expiry Reports"),
        EntryData(image: "appointment", title: "MMSSY Register"),
        EntryData(image: "appointment", title: "MMSSY Labour Beneficiary Register"),
        EntryData(image: "appointment", title: "Incident Register"),
        EntryData(image: "appointment", title: "Attendance Register"),
        EntryData(image: "appointment", title: "Stock Taking Register"),
        EntryData(image: "appointment", title: "Penalty Register"),
        EntryData(image: "appointment", title: "Equipment Checklist Register"),
    ]
    
    let PendingApproval = [
        EntryData(image: "appointment", title: "Pending Indent For Approval (CO)"),
        EntryData(image: "appointment", title: "Pending Indent For Approval (APM)"),
        EntryData(image: "appointment", title: "Pending Indent For Approval (Auditor)"),
        EntryData(image: "appointment", title: "Pending approval list of employee registration (APM)"),
        EntryData(image: "appointment", title: "Pending approval list of employee registration (Auditor)"),
        EntryData(image: "appointment", title: "Pending approval list of employee registration (CHMO)"),
        EntryData(image: "appointment", title: "Pending approval list of employee registration (UPSS)"),
    ]
}
