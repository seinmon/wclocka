/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class ReminderDetailsPresenter {
    typealias numberOfCells = Int
    
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    private var dataSource: Reminder?
    
    private enum CellID: String {
        case TwoLabels = "TwoLabelsCell"
        case TextField = "TextFieldCell"
        case Switch = "SwitchCell"
        case DatePicker = "DatePickerCell"
        case DeleteButton = "DeleteButtonCell"
    }
    
    required init(coordinator: Coordinator,
                  controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
    }
    
    convenience init(data: Any, coordinator: Coordinator, controller: UIViewController) {
        self.init(coordinator: coordinator, controller: controller)
        
        if let reminder = data as? Reminder {
            self.dataSource = reminder
            //} else if let timezone = data as? RowContent {
            
        }
    }
    

    private func getIndexAndCellID(for section: Int, row: Int? = nil) -> (CellID, numberOfCells){
        switch section {
            
        case 0:
            return (CellID.TwoLabels, 1)
        case 1:
            return (CellID.TextField, 2)
        case 2:
            if let rowIndex = row {
              if (rowIndex % 2 == 1 && getRowCount(inSection: section) > 2) {
                return (CellID.DatePicker, getRowCount(inSection: section) + 1)
              }
            }
            // TODO: Change 2 if the reminder type is reoccuring
            return (CellID.Switch, 2)
        case 3:
            return (CellID.DeleteButton, 1)
        default:
            return (CellID.TwoLabels, 0)
        }
    }
}

extension ReminderDetailsPresenter: Presenter {
    var viewControllerTitle: String {
        return "Create Reminder"
    }
    
    subscript(indexPath: IndexPath) -> Any {
        return viewController
    }
    
    func getSectionCount() -> Int {
        return 4
    }
    
    func getSectionHeaderTitle(for section: Int) -> String? {
        return " "
    }
    
    func getRowCount(inSection section: Int) -> Int {
        return getIndexAndCellID(for: section).1
    }
    
    func getCellReusableIdentifier(for indexPath: IndexPath) -> String {
        return getIndexAndCellID(for: indexPath.section, row: indexPath.row).0.rawValue
    }
}
