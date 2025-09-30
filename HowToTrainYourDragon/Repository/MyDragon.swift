//
//  UsersDragon.swift
//  HowToTrainYourDragon
//
//  Created by alex on 22/8/2025.
//

import Foundation
import FirebaseFirestore

struct MyDragon {
    var id : String
    var name : String
//    var bloodline : DocumentReference
    var bloodline : String // this is for now, later we will change it to DocumentReference when the DB is ready.
    var attack : Int
    var defence : Int
    var speed : Int
    var acquiredOn : Timestamp
    var wins : Int
    var draws : Int
    var losses : Int
    
    
}
