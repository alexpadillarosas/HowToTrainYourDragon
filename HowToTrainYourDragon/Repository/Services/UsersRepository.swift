//
//  UserRepository.swift
//  HowToTrainYourDragon
//
//  Created by alex on 11/9/2025.
//

import Foundation
import FirebaseFirestore

//// A custom error type for better error propagation
//enum UserRepositoryError: Error, LocalizedError {
//    case documentIdNotFound
//    case firestoreError(Error)
//    case encodingError(Error)
//
//    var errorDescription: String? {
//        switch self {
//        case .documentIdNotFound: return "User ID is required for this operation."
//        case .firestoreError(let error): return "Firestore operation failed: \(error.localizedDescription)"
//        case .encodingError(let error): return "Failed to encode User object: \(error.localizedDescription)"  //we only have this is we use Codable
//        }
//    }
//}

class UsersRepository {
    
    static let sharedUserRepository = UsersRepository()
    private let usersCollection: CollectionReference
    
    init() {
        let db = Firestore.firestore()
        self.usersCollection = db.collection("users")
    }
    
    ///Add or update a user
    /// - Parameter user: The user struct containing the data
    /// - user.id is the user email
    func addOrUpdateUser(user: User) async throws { // The 'async' keyword here is crucial!
        guard let userId = user.id else {
            throw HttydError.userIdNotFound
        }

        do {
            // This is the async version of setData(from:)
            try usersCollection.document(userId).setData(from: user, merge: true)
            print("User \(userId) saved successfully!")
        } catch let encodingError as EncodingError {
            print("Error encoding user for Firestore: \(encodingError.localizedDescription)")
            throw HttydError.encodingError(encodingError)
        } catch {
            print("Error saving user to Firestore: \(error.localizedDescription)")
            throw HttydError.firestoreError(error)
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
            throw HttydError.firestoreError(error)
        }
    }
    
    // Function to get a user by their document ID
    func getUserByID(userID: String) async throws -> User? {
        
        let docRef = usersCollection.document(userID)

        do {
            // Use getDocument(as:) to directly decode the Firestore document into your User struct
            let user = try await docRef.getDocument(as: User.self)
            return user
        } catch let encodingError as EncodingError {
            print("Error encoding user for Firestore: \(encodingError.localizedDescription)")
            throw HttydError.encodingError(encodingError)
        } catch {
            // Handle cases where the document might not exist or decoding fails
            print("Error fetching or decoding user: \(error.localizedDescription)")
            throw HttydError.firestoreError(error) // Re-throw the error for the caller to handle
        }
    }

}
