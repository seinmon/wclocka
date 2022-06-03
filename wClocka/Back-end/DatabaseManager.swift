/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

/// Static constants that are required for Core Data
fileprivate struct StaticDatabaseConstants {
    fileprivate static var managedObjectContext: NSManagedObjectContext {
        return StaticDatabaseConstants.persistentContainer.viewContext
    }
    
    fileprivate static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "wClocka")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // TODO: - Show an alert that there is an unrecoverable error
                fatalError("PersistentContainer Unrecoverable Error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

class DatabaseTransactionManager<Model: SelfManagedObject> {
    weak var context: NSManagedObjectContext!
    
    init() {
        self.context = StaticDatabaseConstants.persistentContainer.viewContext
    }
    
    internal func fetchResultsController(sortDescriptor: NSSortDescriptor,
                                        predicate: NSPredicate? = nil)
    -> NSFetchedResultsController<Model>? {
        guard let request = Model.fetchRequest() as? NSFetchRequest<Model> else {
            return nil
        }
        
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        
        do {
            let fetchedResults = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            try fetchedResults.performFetch()
            return fetchedResults
            
        } catch let error as NSError {
            // TODO: - Show an alert that there is an unrecoverable error (maybe?)
            fatalError("Could not fetch NSFetchedResultsController: \(error), \(error.userInfo)")
        }
    }
    
    internal func saveData(data: Any) {
        let model = Model(context: context)
        model.write(data)
        saveContext()
    }
    
    internal func update(_ oldData: SelfManagedObject, newData: Any) {
        oldData.update(to: newData)
        saveContext()
    }
    
    internal func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
    internal func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                // TODO: - Show an alert that there is an unrecoverable error
                fatalError("Unrecoverable error in saving context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
