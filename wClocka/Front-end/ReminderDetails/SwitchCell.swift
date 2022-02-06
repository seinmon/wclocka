/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit
import UserNotifications

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
        
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings {[weak self] settings in
            if (settings.authorizationStatus == .denied) {
                DispatchQueue.main.async {
                    self?.switchLabel.isEnabled = false
                    self?.switchButton.isEnabled = false
                    self?.switchButton.isOn = false
                }
            } else {
                DispatchQueue.main.async {
                    self?.switchButton.isOn = (self?.dataSource?.notification ?? false)
                }
            }
        }
    }
    
    @IBAction func switchTouchUpInside(_ sender: UISwitch) {
        guard let viewController = viewController as? ReminderDetailsTableViewController else {
            return
        }
        
        dataSource?.notification = switchButton.isOn
        
        if (switchButton.isOn) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound, .badge]) {[weak self] granted, error in
                
                if let error = error {
                    print("BEATCH")
                }
                
                if granted {
                    DispatchQueue.main.async {
                        viewController.tableView.insertRows(at: [IndexPath(row: (self?.indexPath?.row ?? 0) + 1,
                                                                           section: self?.indexPath?.section ?? 2)],
                                                            with: .automatic)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.switchButton.isOn = false
                    }
                }
            }
        } else {
            viewController.tableView.deleteRows(at: [IndexPath(row: (indexPath?.row ?? 0) + 1,
                                                               section: indexPath?.section ?? 2)],
                                                with: .automatic)
            dataSource?.notificationTime = nil
        }
    }
}

