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
        EntryData(image: "mmu_register", title: "MMU Register"),
        EntryData(image: "opd_report", title: "OPD Reports"),
        EntryData(image: "camp_plan", title: "Monthly Camp Reports"),
        EntryData(image: "daily_mmu_register", title: "Daily MMU Register"),
        EntryData(image: "indent_register", title: "Indent Register"),
        EntryData(image: "medicine_issue", title: "Medicine Issue Register"),
        EntryData(image: "stock_staus", title: "Stock Status Reports"),
        EntryData(image: "opening_balance", title: "Opening Balance Register"),
        EntryData(image: "drug_expiry", title: "Drug Expiry Reports"),
        EntryData(image: "drug_expiry", title: "MMSSY Information Register"),
        EntryData(image: "drug_expiry", title: "MMSSY Labour Beneficiary Register"),
        EntryData(image: "drug_expiry", title: "Dai Didi Clinic Register"),
        EntryData(image: "drug_expiry", title: "Incident Register"),
        EntryData(image: "drug_expiry", title: "Attendance Register"),
        EntryData(image: "drug_expiry", title: "Stock Taking Register"),
        EntryData(image: "drug_expiry", title: "Penalty Register"),
        EntryData(image: "mmu_register", title: "Equipment Checklist Register"),
    ]
    
    let PendingApproval = [
        EntryData(image: "COApproval", title: "Pending Indent For Approval (CO)"),
        EntryData(image: "APMApproval", title: "Pending Indent For Approval (APM)"),
        EntryData(image: "indent_auditor", title: "Pending Indent For Approval (Auditor)"),
        EntryData(image: "pending_emp_reg_apm", title: "Pending approval list of employee registration (APM)"),
        EntryData(image: "pending_emp_reg_auditor", title: "Pending approval list of employee registration (Auditor)"),
        EntryData(image: "pending_emp_reg_apm", title: "Pending approval list of employee registration (CHMO)"),
        EntryData(image: "pending_emp_reg_auditor", title: "Pending approval list of employee registration (UPSS)"),
    ]
}
