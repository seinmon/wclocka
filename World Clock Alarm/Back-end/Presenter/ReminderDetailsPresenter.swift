/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class ReminderDetailsPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    private var dataSource: Reminder?
    
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
}

extension ReminderDetailsPresenter: Presenter {
    var viewControllerTitle: String {
        return "Create Reminder"
    }
    
    subscript(indexPath: IndexPath) -> Any {
        return viewController
    }
    
    func getSectionCount() -> Int {
        3
    }
    
    func getRowCount(inSection section: Int) -> Int {
        switch section {
            
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 2
        default:
            return 0
        }
    }
    
    func getCellReusableIdentifier(for indexPath: IndexPath) -> String {
        switch indexPath.section {
            
        case 0:
            return "TwoLabelsCell"
        case 1:
            return "DatePickerCell"
        case 2:
            return "TextFieldCell"
        default:
            return "TwoLablesCell"
        }
    }
}
