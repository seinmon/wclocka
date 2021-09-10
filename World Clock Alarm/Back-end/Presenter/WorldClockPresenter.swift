/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

class WorldClockPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    private var dataSource: NSFetchedResultsController<Timezone>?

    internal var dataSourceIsEmpty: Bool {
        return (dataSource?.fetchedObjects?.isEmpty ?? true)
    }
    
    required init(coordinator: Coordinator, controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
        
        dataSource = DatabaseManager.shared.fetch()
        dataSource?.delegate = viewController as? WorldClockTableViewController
    }
}

extension WorldClockPresenter: Presenter {
    
    subscript(indexPath: IndexPath) -> Any {
        get {
            return dataSource?.fetchedObjects?[indexPath.row] as Any
        }
    }
    
    func getSectionCount() -> Int {
        return dataSource?.sections?.count ?? 0
    }
    
    func getRowCount(inSection section: Int) -> Int {
        dataSource?.fetchedObjects?.count ?? 0
    }
    
    func didSelectBarButtonItem() {
        coordinator.start()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: self[indexPath])
    }
    
    func deleteFromDataSource(indexPath: IndexPath) -> Bool {
        guard let managedObject = dataSource?.object(at: indexPath) else {
            return false
        }
        
        if (managedObject.reminders?.count ?? 0) > 0 {
            return false
        }
        
        DatabaseManager.shared.delete(managedObject)
        return true
    }
}

extension WorldClockPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        if let receivedData = data as? rowContent {
            if !isDuplicate(receivedData) {
                DatabaseManager.shared.saveData(data: receivedData)
            }
        }
    }
    
    private func isDuplicate(_ newData: rowContent) -> Bool {
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
