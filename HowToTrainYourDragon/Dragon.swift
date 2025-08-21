//
//  Dragon.swift
//  HowToTrainYourDragon
//
//  Created by alex on 20/8/2025.
//

import Foundation

struct Dragon {
    enum Attribute {
        case attack
        case defence
        case speed
    }
    
    var type : String
    var species : String
    var bestAt : Attribute
    var attack : Int
    var defence: Int
    var speed : Int
    
}
