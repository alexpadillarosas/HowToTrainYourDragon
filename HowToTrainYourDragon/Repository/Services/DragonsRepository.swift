//
//  DragonsRepository.swift
//  HowToTrainYourDragon
//
//  Created by alex on 12/9/2025.
//

import Foundation
import FirebaseFirestore

class DragonsRepository {
    static let sharedDragonsRepository = DragonsRepository()
    private let dragonsCollection: CollectionReference

    init(){
        let db = Firestore.firestore()
        dragonsCollection = db.collection("dragons")
    }

    //This is a trailing closure: A function whose last parameter is a closure
    //the closure receives an contact's array and returns nothing
    func findAllDragonsLive( completion : @escaping ([Dragon]) -> ()){
        _ = dragonsCollection
            .addSnapshotListener { snapshot, error in  //we add a listener, so we can listen for updates made to our db, it returns a current snapshot with the found data, and an error if there is any
                
                // Handle errors from the Firestore listener itself
                  guard error == nil else {
                      print("Firebase Listener Error for Dragons: \(error!.localizedDescription)")
                      // Since the completion block cannot carry an Error, we signal failure
                      // by passing an empty array. This implies no valid data was retrieved.
                      completion([])
                      return
                  }

                  // Guard against a nil snapshot (though this is rare if no `error` is present)
                  guard let snapshot = snapshot else {
                      print("No snapshot data available for dragons collection.")
                      completion([])
                      return
                  }
                  
                  var decodedDragons: [Dragon] = []
                  
                  // Loop through each document in the snapshot
                  for document in snapshot.documents {
                      do {
                          
                          // This is the correct way to decode a Firestore document into your Codable struct, It automatically maps fields
                          // and handles `@DocumentID` for the `id` property.
                          let dragon = try document.data(as: Dragon.self)
//                          print("\(dragon.id) \(dragon.bestAt) \(dragon.species) \(dragon.type)  \(dragon.attack) \(dragon.defence) \(dragon.speed)")
                          
                          decodedDragons.append(dragon)
                      } catch {
                          // If a document fails to decode (e.g., missing field, wrong type),
                          // we log the error but continue processing other documents.
                          // The problematic document is simply skipped, as we cannot
                          // report the individual decoding error via the completion block.
                          print("Error decoding document \(document.documentID) into Dragon: \(error.localizedDescription)")
                      }
                  }

                completion(decodedDragons) //we execute the completion which is a block of code received as parameter
                    
            }
    }
    
    
    
    // Function to get a dragon by its document ID
    func getDragonByID(dragonID: String) async throws -> Dragon {
        
        // Assuming your dragons are stored in a collection named "dragons"
        let docRef = dragonsCollection.document(dragonID)

        do {
            let dragon: Dragon? = try await docRef.getDocument(as: Dragon.self)

            // Check if the document was found and successfully decoded
            guard let existingDragon = dragon else {
                print("Dragon document with ID '\(dragonID)' not found.")
                throw HttydError.dragonIdNotFound // Throw our custom error
            }

            return existingDragon

        } catch let decodingError as DecodingError {
            // Catch specific decoding errors (e.g., mismatch in data types or missing fields)
            print("Decoding error for dragon '\(dragonID)': \(decodingError)")
            throw HttydError.encodingError(decodingError)
        } catch {
            // Catch any other Firestore or network-related errors
            print("Unexpected error fetching dragon '\(dragonID)': \(error.localizedDescription)")
            throw HttydError.firestoreError(error)
        }
    }
    

    /*
    func getBloodlineDragon(for myDragon : MyDragon) async throws -> Dragon {
        let bloodlineRef = myDragon.bloodline // This is already a DocumentReference!
            do {
                // Use the DocumentReference directly to fetch and decode the Dragon
                let dragon: Dragon? = try await bloodlineRef.getDocument(as: Dragon.self)

                guard let existingDragon = dragon else {
                    print("Bloodline Dragon document at path '\(bloodlineRef.path)' not found.")
                    // Using DragonError.dragonNotFound for consistency, as we're looking for a Dragon
                    throw HttydError.dragonReferenceNotFound
                }

                return existingDragon

            } catch let decodingError as DecodingError {
                print("Decoding error for bloodline Dragon at path '\(bloodlineRef.path)': \(decodingError)")
                throw HttydError.encodingError(decodingError)
            } catch {
                print("Unexpected error fetching bloodline Dragon at path '\(bloodlineRef.path)': \(error.localizedDescription)")
                throw HttydError.firestoreError(error)
            }
        
        
    }
    
    */
    
    
    
    
    
}
