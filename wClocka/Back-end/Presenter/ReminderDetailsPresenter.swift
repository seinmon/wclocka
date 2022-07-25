/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

class ReminderViewModel {
    public var title: String = ""
    public var details: String?
    public var notificationTime: Date?
    public var notificationUUID: String?
    public var reoccuring: Bool = true
    public var timezone: Timezone?
    public var notification: Bool = false

    func write(_ data: Any) {
        if let entry = data as? Reminder {
            self.timezone = entry.timezone
            self.title = entry.title
            self.details = entry.details
            self.notificationTime = entry.notificationTime
            self.notificationUUID = entry.notificationUUID
            self.notification = (notificationTime != nil)
            self.reoccuring = entry.reoccuring
        } else if let entry = data as? Timezone {
            self.timezone = entry
        }
    }
}

class ReminderDetailsPresenter {
    typealias RowCount = Int

    internal let coordinator: Coordinator
    internal unowned let viewController: UIViewController
    private var dataSource: ReminderViewModel
    private var oldData: Reminder?

    private enum CellID: String {
        case twoLabelsCell = "TwoLabelsCell"
        case textFieldCell = "TextFieldCell"
        case switchCell = "SwitchCell"
        case datePickerCell = "DatePickerCell"
        case deleteButtonCell = "DeleteButtonCell"
    }

    private enum CellSectionIndex: Int {
        case twoLabelsCell = 0
        case textFieldCell = 1
        case switchAndPickerCell = 2
        case deleteButtonCell = 3
    }

    required init(coordinator: Coordinator,
                  controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
        self.dataSource = ReminderViewModel()
    }

    convenience init(data: Any, coordinator: Coordinator, controller: UIViewController) {
        self.init(coordinator: coordinator, controller: controller)

        if let data = data as? Reminder {
            self.oldData = data
        }

        dataSource.write(data)
    }

    private func getCellIDAndRowCount(for section: Int, row: Int? = nil) -> (CellID, RowCount) {
        switch section {

        case 0:
            return (CellID.twoLabelsCell, 1)
        case 1:
            return (CellID.textFieldCell, 1)
        case 2:
            if let rowIndex = row {
                if rowIndex % 2 == 1 && getRowCount(inSection: section) >= 2 {
                    return (CellID.datePickerCell, getRowCount(inSection: section) + 1)
                }
            }

            return (dataSource.notification ? (CellID.switchCell, 2) : (CellID.switchCell, 1))
        case 3:
            return (CellID.deleteButtonCell, 1)
        default:
            return (CellID.twoLabelsCell, 0)
        }
    }
}

extension ReminderDetailsPresenter: Presenter {
    var viewControllerTitle: String {
        if !dataSource.title.isEmpty {
            return dataSource.title
        }

        return "Create Reminder"
    }

    subscript(indexPath: IndexPath) -> Any {
        return (dataSource, indexPath, viewController)
    }

    func getSectionCount() -> Int {
        return (oldData == nil
                ? (CellSectionIndex.switchAndPickerCell.rawValue + 1)
                : (CellSectionIndex.deleteButtonCell.rawValue + 1))
    }

    func getSectionHeaderTitle(for section: Int) -> String? {
        return " "
    }

    func getRowCount(inSection section: Int) -> Int {
        return getCellIDAndRowCount(for: section).1
    }

    func getCellReusableIdentifier(for indexPath: IndexPath) -> String {
        return getCellIDAndRowCount(for: indexPath.section, row: indexPath.row).0.rawValue
    }

    func didSelectBarButtonItem() {
        let databaseManager = DatabaseTransactionManager<Reminder>()

        if dataSource.notificationUUID == nil {
            dataSource.notificationUUID = UUID().uuidString
        }

        if let oldData = oldData {
            databaseManager.update(oldData, newData: dataSource)
            coordinator.start(with: oldData)
        } else {
            databaseManager.saveData(data: dataSource)
        }

        let notificationManager = NotificationManager()

        if let notificationTime = dataSource.notificationTime {
            if let timezone = dataSource.timezone?.timezone {
                let notificationManager = NotificationManager()
                notificationManager
                    .scheduleNotification(
                        notificationTime: notificationTime,
                        timezone: timezone,
                        identifier: dataSource.notificationUUID!,
                        message: dataSource.timezone!.zoneTitle + ": " + dataSource.title)
            }
        } else {
            notificationManager.cancelNotification(identifier: dataSource.notificationUUID!)
        }

        viewController.dismiss(animated: true)
    }

    func didSelectRow(at indexPath: IndexPath) {
        if indexPath.section == CellSectionIndex.deleteButtonCell.rawValue {
            let databaseManager = DatabaseTransactionManager<Reminder>()
            if let oldData = oldData {
                if dataSource.notification {
                    let notificationManager = NotificationManager()
                    notificationManager.cancelNotification(identifier: dataSource.notificationUUID!)
                }

                databaseManager.delete(oldData)
            }

            viewController.dismiss(animated: true)
        }
    }

    func dismissCompletion() {
        coordinator.start(with: nil)
    }
}
