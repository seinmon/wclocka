/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

fileprivate struct DatabaseConstants {
    fileprivate static var managedObjectContext: NSManagedObjectContext {
        return DatabaseConstants.persistentContainer.viewContext
    }
    
    fileprivate static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "wClocka")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("PersistentContainer Unrecoverable Error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

class DatabaseTransactionManager<Model: SelfManagedObject> {
    weak var context: NSManagedObjectContext!
    
    init() {
        self.context = DatabaseConstants.persistentContainer.viewContext
    }
    
    internal func fetch(sortDescriptor: NSSortDescriptor,
               predicate: NSPredicate? = nil) -> NSFetchedResultsController<Model>? {
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
                fatalError("Unrecoverable error in saving context: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
