/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    private var dataSource: [ClockModel] = []

    internal var allowsEditing: Bool {
        return !dataSource.isEmpty
    }
    
    required init(coordinator: Coordinator, controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
    }
}

extension WorldClockPresenter: Presenter {
    
    subscript(indexPath: IndexPath) -> Any {
        get {
            return dataSource[indexPath.row]
        }
    }
    
    func getSectionCount() -> Int {
        return 1
    }
    
    func getRowCount(inSection section: Int) -> Int {
        dataSource.count
    }
    
    func didSelectBarButtonItem() {
        coordinator.start()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: self[indexPath])
    }
    
    func deleteFromDataSource(indexPath: IndexPath) -> Bool {
        dataSource.remove(at: indexPath.row)
        return true
    }
}

extension WorldClockPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        if let receivedData = data as? (String, TimeZone) {
            let clockItem = ClockModel(title: receivedData.0,
                                       timezone: receivedData.1)
            
            dataSource.append(clockItem)
            
            if let tableViewController = viewController as? WorldClockTableViewController {
                tableViewController.tableView.reloadData()
                tableViewController.activateEditButton()
            }
        }
    }
}
