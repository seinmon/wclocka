/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersTableViewCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reoccuringLabel: UILabel!
    
    func configure(with data: Any) {
        guard let reminder = data as? Reminder else {
            return
        }
        
        titleLabel.text = reminder.title
        descriptionLabel.text = reminder.details
        
        /*
        if let notificationTime = reminder.notificationTime {
            timeLabel.text = reminder.timezone?.time ?? "12:34 PM"
            reoccuringLabel.text = (reminder.reoccuring ? "Repeats" : nil)
            dateLabel.text = "1.2.20250"
        } else {
        */
            timeLabel.text = "No notifications"
            reoccuringLabel.text = nil
            dateLabel.text = nil
        //}
    }
}
