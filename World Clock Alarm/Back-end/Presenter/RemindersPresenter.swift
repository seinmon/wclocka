/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

class RemindersPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    private var dataSource: NSFetchedResultsController<Reminder>?
    private var timezone: Timezone?
    private lazy var databaseManager = DatabaseTransactionManager<Reminder>()
    
    internal var dataSourceIsEmpty: Bool {
        return (dataSource?.fetchedObjects?.isEmpty ?? true)
    }
    
    required init(coordinator: Coordinator, controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
    }
    
    convenience init(timezone: Timezone, coordinator: Coordinator, controller: UIViewController) {
        self.init(coordinator: coordinator, controller: controller)
        self.timezone = timezone
        dataSource = databaseManager.fetch(sortDescriptor:
                                           NSSortDescriptor(key: #keyPath(Reminder.title),
                                                             ascending: true))
        dataSource?.delegate = viewController as? RemindersTableViewController
    }
    
}

extension RemindersPresenter: Presenter {
    var viewControllerTitle: String {
        return timezone?.zoneTitle ?? "Reminders"
    }
    
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
}

extension RemindersPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        if let data = data as? Reminder {
            databaseManager.saveData(data: data)
        }
    }
}
