//
//  LocalStorage.swift
//  currenciesPrototype
//
//  Created by Daniel Bermudez on 6/20/19.
//  Copyright © 2019 Endava. All rights reserved.
//

import Foundation
import CoreData

final class LocalStorage {
    // MARK: - Core Data stack
    
    static let shared = LocalStorage()
    
    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "currenciesPrototype")
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            storeDescription.shouldMigrateStoreAutomatically = true
            storeDescription.shouldInferMappingModelAutomatically = false
            if let error = error {
                print("Something went wrong \(error)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = {
        return self.persistenceContainer.viewContext
    }()
    
    // MARK: - CRUDE
    
    func saveContext(completion:(NSError?) -> Void) {
        let context = persistenceContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch let error as NSError {
                print("Unable to save context: \(error.description)")
                completion(error)
            }
            completion(nil)
        }
    }
}
