//
//  UsersDragon.swift
//  HowToTrainYourDragon
//
//  Created by alex on 22/8/2025.
//

import Foundation
import FirebaseFirestore

struct MyDragon : Codable {
    @DocumentID var id : String?
    var name : String
    var parentDragonID : String
    var species : String
    var type : String
    var bestAt : Attribute
    var attack : Int
    var defence : Int
    var speed : Int
    var acquiredOn : Date
    var wins : Int
    var draws : Int
    var losses : Int
    
}
