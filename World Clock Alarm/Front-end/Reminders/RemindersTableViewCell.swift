/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersTableViewCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func configure(with data: Any) {
        guard let reminder = data as? Reminder else {
            return
        }
        
        titleLabel.text = reminder.title
        descriptionLabel.text = reminder.details
        timeLabel.text = reminder.timezone?.time ?? ""
    }
}
