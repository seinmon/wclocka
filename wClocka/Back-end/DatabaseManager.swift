/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

/**
 * Static constants that are required for Core Data
 */
// swiftlint:disable private_over_fileprivate
fileprivate struct StaticDatabaseConstants {
    /**
     * Returns an instant of NSManagedObjectContext of the current application
     */
    fileprivate static var managedObjectContext: NSManagedObjectContext {
        return StaticDatabaseConstants.persistentContainer.viewContext
    }

    /**
     * Returns an instant of NSPersistentContainer of the current application
     */
    fileprivate static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "wClocka")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                // TODO: - Show an alert that there is an unrecoverable error
                fatalError("PersistentContainer Unrecoverable Error: \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

/**
 * Database related functionalities
 *
 * This class implements functionalities related to all the Core Data operations.
 * Since these functionalities should not be dependent on the models, it is written for a generic Model type,
 * which conforms to SelfManagedObject protocol.
 */
class DatabaseTransactionManager<Model: SelfManagedObject> {
    weak var context: NSManagedObjectContext!

    /**
     * Initialize the DatabaseTransactionManager
     */
    init() {
        self.context = StaticDatabaseConstants.persistentContainer.viewContext
    }

    /**
     * Get the NSFetchedResultsController for a model
     *
     * - Parameters:
     *  - sortDescriptor: An array to describe how to sort the fetched data
     *  - predicate: An optional predicate string to use when fetching the data
     *
     * - Returns: Optional NSFetchedResultsController for a SelfManagedObject
     */
    internal func fetch(sortDescriptor: [NSSortDescriptor], predicate: NSPredicate? = nil)
    -> NSFetchedResultsController<Model>? {
        guard let request = Model.fetchRequest() as? NSFetchRequest<Model> else {
            return nil
        }

        request.sortDescriptors = sortDescriptor
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

    /**
     * Write the data to the database without making it persistent
     *
     * - Parameters:
     *  - data: Data to write
     */
    internal func saveData(data: Any) {
        let model = Model(context: context)
        model.write(data)
        saveContext()
    }

    /**
     * Update the existing data to a new value
     *
     * - Parameters:
     *  - oldData: an object of the existing data in the database
     *  - newData: the new values to use when updating the database
     */
    internal func update(_ oldData: SelfManagedObject, newData: Any) {
        oldData.update(to: newData)
        saveContext()
    }

    /**
     * Delete an entry from the database
     *
     * - Parameters:
     *  - object: an object of data to delete from the database
     */
    internal func delete(_ object: NSManagedObject) {
        context.delete(object)
        saveContext()
    }

    /**
     * Save context changes to the persistent container
     */
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
