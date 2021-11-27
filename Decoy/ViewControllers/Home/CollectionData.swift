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
