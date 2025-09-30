//
//  UserRepository.swift
//  HowToTrainYourDragon
//
//  Created by alex on 11/9/2025.
//

import Foundation
import FirebaseFirestore

// A custom error type for better error propagation
enum UserRepositoryError: Error, LocalizedError {
    case documentIDMissing
    case firestoreError(Error)
    case encodingError(Error)

    var errorDescription: String? {
        switch self {
        case .documentIDMissing: return "User ID is required for this operation."
        case .firestoreError(let error): return "Firestore operation failed: \(error.localizedDescription)"
        case .encodingError(let error): return "Failed to encode User object: \(error.localizedDescription)"  //we only have this is we use Codable
        }
    }
}

class UserRepository {
    
    static let sharedUserRepository = UserRepository()
    let db = Firestore.firestore()
    
    private let usersCollection: CollectionReference

    init() {
        self.usersCollection = db.collection("users")
    }
    
    /**
     Adding a user to firestore
     The Id is the user's email
     */
//    func add(withData user : User) async throws {
//        
//        //Guard we have the ID (email)
//        guard let userId = user.id else {
//            throw UserRepositoryError.documentIDMissing
//        }
        
//        let dictionary : [String: Any] = [
//            "username": user.username as String,
//            "firstname": user.firstname as String,
//            "lastname": user.lastname as String,
//            "phone": user.phone as String,
//            "dob": user.dob,
//            "memberSince": user.memberSince
//        ]
        
     
//            try await db.collection("users").document(userId).setData(from: user)  //Doing this will make Firestore automatically map all elements in the User struct to a user Document
//            print("User \(userId) saved successfully!")
//        
//        
//        
//    }
    
    ///
    func addOrUpdateUser(user: User) async throws { // The 'async' keyword here is crucial!
        guard let userId = user.id else {
            throw UserRepositoryError.documentIDMissing
        }

        do {
            // This is the async version of setData(from:)
            try usersCollection.document(userId).setData(from: user, merge: true)
            print("User \(userId) saved successfully!")
        } catch let encodingError as EncodingError {
            print("Error encoding user for Firestore: \(encodingError.localizedDescription)")
            throw UserRepositoryError.encodingError(encodingError)
        } catch {
            print("Error saving user to Firestore: \(error.localizedDescription)")
            throw UserRepositoryError.firestoreError(error)
        }
    }
    
    /// Deletes a user document from the "users" collection.
    /// - Parameter userId: The ID of the user document to delete.
    func deleteUser(userId: String) async throws {
        do {
            // Firestore's delete() method is an async operation
            try await usersCollection.document(userId).delete()
            print("User \(userId) deleted successfully!")
        } catch {
            // Catch any errors from Firestore and re-throw them using your custom error type
            throw UserRepositoryError.firestoreError(error)
        }
    }

}
