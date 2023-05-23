//
//  FinditController.swift
//  Findit
//
//  Created by Ivan on 23/05/23.
//

import Foundation
import SwiftUI
import CoreData

class FinditController: ObservableObject {
    // For initializing the Core Data stack and loading the Core Data model file
    let persistentContainer: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        // Access the model file
        persistentContainer = NSPersistentContainer(name: "FinditDataModel")
        
        // Don't save information for future use if running in memory...
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        // Attempt to load persistent stores (the underlying storage of data)
        persistentContainer.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load date: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addItem(
        name: String,
        logo: String,
        beaconUUIDString: String,
        beaconMajor: Int16,
        beaconMinor: Int16,
        context: NSManagedObjectContext
    ) {
        let item = Item(context: context)
        item.id = UUID()
        item.name = name
        item.logo = logo
        item.createdAt = .now
        item.beaconUUID = UUID(uuidString: beaconUUIDString)
        item.beaconMajor = beaconMajor
        item.beaconMinor = beaconMinor
        
        save(context: context)
    }
}

extension FinditController {
    // For use with Xcode Previews, provides some data to work with for examples
    static var preview: FinditController = {
        
        // Create an instance of the provider that runs in memory only
        let finditController = FinditController(inMemory: true)
        
        // New Movie instance is tied to the managed object context
        let item = Item(context: finditController.persistentContainer.viewContext)
        item.id = UUID()
        item.name = "Bag"
        item.logo = "🎒"
        item.createdAt = .now
        item.beaconUUID = UUID(uuidString: "cb10023f-a318-3394-4199-a8730c7c1aec")
        item.beaconMajor = 222
        item.beaconMinor = 155
        
        // Now save these movies in the Core Data store
        do {
            try finditController.persistentContainer.viewContext.save()
        } catch {
            // Something went wrong
            print("Failed to save test movies: \(error)")
        }

        return finditController
    }()
    
    // Example movie for Xcode previews
    static var example: Item {
        
        // Get the first movie from the in-memory Core Data store
        let context = FinditController.preview.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
}
