/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class SwitchCell: UITableViewCell, CellConfigurable {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    weak var dataSource: ReminderViewModel?
    weak var viewController: UIViewController?
    var indexPath: IndexPath?
    
    func configure(with data: Any) {
        guard let data = data as? ReminderDetailsCell else {
            return
        }
        
        dataSource = data.0
        viewController = data.2
        
        switchLabel.text = "Notification"
        switchButton.isOn = (dataSource?.notification ?? false)
    }
    
    @IBAction func switchTouchUpInside(_ sender: UISwitch) {
        guard let viewController = viewController as? ReminderDetailsTableViewController else {
            return
        }
        
        dataSource?.notification = switchButton.isOn
 
        if (switchButton.isOn) {
            viewController.tableView.insertRows(at: [IndexPath(row: (indexPath?.row ?? 0) + 1,
                                                               section: indexPath?.section ?? 2)],
                                                with: .automatic)
        } else {
            viewController.tableView.deleteRows(at: [IndexPath(row: (indexPath?.row ?? 0) + 1,
                                                               section: indexPath?.section ?? 2)],
                                                with: .automatic)
            dataSource?.notificationTime = nil
        }
    }
}

