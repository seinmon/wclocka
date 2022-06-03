/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

class WorldClockPresenter {
    internal let coordinator: Coordinator
    internal unowned let viewController: UIViewController
    internal var dataSource: NSFetchedResultsController<Timezone>?
    private lazy var databaseManager = DatabaseTransactionManager<Timezone>()
    
    required init(coordinator: Coordinator, controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
        
        dataSource = databaseManager.fetchResultsController(sortDescriptor: NSSortDescriptor(
            key: #keyPath(Timezone.zoneTitle), ascending: true))
        dataSource?.delegate = viewController as? WorldClockTableViewController
    }
}

extension WorldClockPresenter: CoreDataPresenter {
    var viewControllerTitle: String {
        return "Time Zones"
    }
    
    func getCellReusableIdentifier(for indexPath: IndexPath) -> String {
        return "WorldClockCell"
    }
    
    func showDeletionWarning(indexPath: IndexPath) -> Bool {
        guard let managedObject = dataSource?.object(at: indexPath) else {
            return false
        }
        
        if (managedObject.reminders?.count ?? 0) > 0 {
            return true
        }
        
        return false
    }
    
    func deleteFromDataSource(indexPath: IndexPath) {
        guard let managedObject = dataSource?.object(at: indexPath) else {
            return
        }
        
        databaseManager.delete(managedObject)
    }
}

extension WorldClockPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        if let receivedData = data as? NewTimezoneRow {
            if !isDuplicate(receivedData) {
                databaseManager.saveData(data: receivedData)
            }
        }
    }
    
    private func isDuplicate(_ newData: NewTimezoneRow) -> Bool {
        if let dataSource = dataSource?.fetchedObjects  {
            for entry in dataSource {
                if entry.zoneTitle == newData.0 {
                    return true
                }
            }
        }
        
        return false
    }
}
