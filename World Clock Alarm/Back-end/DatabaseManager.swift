/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

private struct DatabaseConstants {
    fileprivate static var context: NSManagedObjectContext {
        return DatabaseConstants.persistentContainer.viewContext
    }
    
    fileprivate static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "World_Clock_Alarm")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

class DatabaseTransactionManager<Model: SelfManagedObject> {
    private var context: NSManagedObjectContext
    
    init() {
        self.context = DatabaseConstants.context
    }
    
    func fetch(sortDescriptor: NSSortDescriptor) -> NSFetchedResultsController<Model>? {
        guard let request = Model.fetchRequest() as? NSFetchRequest<Model> else {
            return nil
        }
        request.sortDescriptors = [sortDescriptor]
        do {
            let fetchedResults = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            
            try fetchedResults.performFetch()
            return fetchedResults
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveData(data: Any) {
        let model = Model(context: context)
        model.write(data)
        saveContext()
    }
    
    func update(_ oldData: SelfManagedObject, newData: Any) {
        oldData.update(to: newData)
        saveContext()
    }
    
    func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }
    
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
