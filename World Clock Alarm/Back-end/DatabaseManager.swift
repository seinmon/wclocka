/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

class DatabaseManager {
    
    static var shared = DatabaseManager()
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "World_Clock_Alarm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Required Functionalities
    
    func fetch() -> NSFetchedResultsController<Timezone>? {
        let request = Timezone.fetchRequest() as NSFetchRequest<Timezone>
        let sort = NSSortDescriptor(key: #keyPath(Timezone.zoneTitle), ascending: true)
        request.sortDescriptors = [sort]
        do {
            let fetchedResults = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: persistentContainer.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            try fetchedResults.performFetch()
            return fetchedResults
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveData(data: (String, TimeZone)) {
        let tz = Timezone(context: context)
        tz.zoneTitle = data.0
        tz.zoneIdentifier = data.1.identifier
        saveContext()
    }
    
    func update(_ data: NSManagedObject) {
        
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
