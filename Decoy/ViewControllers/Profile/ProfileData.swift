//
//  ProfileData.swift
//  Decoy
//
//  Created by Chandan Jee on 24/10/21.
//  Copyright © 2020 intek. All rights reserved.
//

import Foundation
class Entry {
    let image : String
    let title : String
    init(image : String, title : String) {
        self.image = image
        self.title = title
    }
}

class ProfileData {
    let data = [
       // Entry(image: "accountIcon", title: "Account"),
       // Entry(image: "settingIcon", title: "Settings"),
       // Entry(image: "backupIcon", title: "Backup"),
        Entry(image: "latestUpdateIcon", title: "Latest Updates"),
        Entry(image: "Privacy_policy", title: "Privacy Policy"),
        Entry(image: "handbook", title: "User Manual"),
//        Entry(image: "latestUpdateIcon", title: "Message backup"),
//        Entry(image: "settingIcon", title: "Chat Background image"),
//        Entry(image: "status", title: "update status"),
//        Entry(image: "faq", title: "FAQ"),
//        Entry(image: "contactsus", title: "Contacts us"),
//        Entry(image: "accountIcon", title: "Pin protection enable"),
        
      //  Entry(image: "handbook", title: "User Manual or Help"),
//        Entry(image: "accountIcon", title: "Logout"),
       
//        Entry(image: "latestUpdateIcon", title: "Message backup"),
    ]
}
