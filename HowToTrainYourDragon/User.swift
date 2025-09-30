//
//  Dragon.swift
//  HowToTrainYourDragon
//
//  Created by alex on 20/8/2025.
//

import Foundation
import FirebaseFirestore

struct User : Codable, Identifiable {
    //@DocumentID only works when you decode Firestore docs into a model
    @DocumentID var id: String? //@DocumentID needs Codable, because Firestore decoding relies on it.
    var username : String
    var firstname : String
    var lastname : String
    var dob : Date
    var memberSince : Date!
    var phone: String
    
    ///This initialiser is used when creating a user passing all values specially:
    /// - Parameter mermberSince: When we call this function we set the memberSince Date with current Date, which it should not be modified after registered. To update other fields, use the other init
    init(id: String? = nil, username: String, firstname: String, lastname: String, dob: Date, memberSince: Date, phone: String) {
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.dob = dob
        self.memberSince = memberSince
        self.phone = phone
    }
    /// We need this initialiser
    init(id: String? = nil, username: String, firstname: String, lastname: String, dob: Date, phone: String) {
        self.id = id
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.dob = dob
        
        self.phone = phone
    }
}
