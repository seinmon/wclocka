/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class SwitchCell: UITableViewCell, CellConfigurable {
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    weak var dataSource: ReminderViewModel?
    weak var viewController: UIViewController?
    
    func configure(with data: Any) {
        guard let data = data as? ReminderDetailsCell else {
            return
        }
        
        dataSource = data.0
        viewController = data.2
        
        if (data.1.row == 0) {
            switchLabel.text = "Send Notification"
            switchButton.isOn = (dataSource?.notificationTime != nil)
        } else {
            switchLabel.text = "Reoccuring"
            switchButton.isOn = dataSource?.reoccuring ?? true
        }
    }
    
    @IBAction func Switch(_ sender: UISwitch) {
        
    }
}

