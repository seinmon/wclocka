/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

class RemindersPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    internal var dataSource: NSFetchedResultsController<Reminder>?
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
        
        dataSource = databaseManager
            .fetch(sortDescriptor: NSSortDescriptor(key: #keyPath(Reminder.title), ascending: true),
                   predicate: NSPredicate(format: "timezone.zoneTitle == %@", timezone.zoneTitle))
        dataSource?.delegate = viewController as? RemindersTableViewController
    }
    
}

extension RemindersPresenter: CoreDataPresenter {
    var viewControllerTitle: String {
        return timezone?.zoneTitle ?? "Reminders"
    }
    
    func didSelectBarButtonItem() {
        coordinator.start(with: timezone as Any)
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: self[indexPath])
    }
    
    func getCellReusableIdentifier(for indexPath: IndexPath) -> String {
        return "ReminderCell"
    }
    
    func deleteFromDataSource(indexPath: IndexPath) {
        guard let managedObject = dataSource?.object(at: indexPath) else {
            return
        }
        
        
        if managedObject.notificationTime != nil {
            if let notificationUUID = managedObject.notificationUUID {
                let notificationManager = NotificationManager()
                notificationManager.cancelNotification(identifier: notificationUUID)
            }
        }
        
        databaseManager.delete(managedObject)
    }
}

extension RemindersPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        didMoveBackwardsWithNoData()
    }
    
    func didMoveBackwardsWithNoData() {
        guard let tableViewController = viewController as? RemindersTableViewController else {
            return
        }
        
        tableViewController.tableView.reloadData()
    }
}
