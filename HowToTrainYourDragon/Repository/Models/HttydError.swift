//
//  UserError.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/9/2025.
//

import Foundation

// A custom error type for better error propagation
enum HttydError: Error, LocalizedError {
    case userIdNotFound
    case dragonIdNotFound
    case dragonReferenceNotFound
    case firestoreError(Error)
    case encodingError(Error)

    var errorDescription: String? {
        switch self {
        case .userIdNotFound:
            return "User ID not found."
        case .dragonIdNotFound:
            return "Dragon ID not found."
        case .dragonReferenceNotFound:
            return "Dragon Reference not found"
        case .firestoreError(let error):
            return "Firestore operation failed: \(error.localizedDescription)"
        case .encodingError(let error):
            return "Failed to encode User object: \(error.localizedDescription)"  //we only have this is we use Codable
        }
    }
}
