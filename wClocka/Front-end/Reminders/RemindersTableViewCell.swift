/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersTableViewCell: UITableViewCell, CellConfigurable {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var reminder: Reminder!

    func configure(with data: Any) {
        guard let reminder = data as? Reminder else {
            return
        }

        self.reminder = reminder

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didEnterForeground),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)

        titleLabel.text = reminder.title
        didEnterForeground()
    }

    @objc
    func didEnterForeground() {
        if let notificationTime = reminder.notificationTime {
            NotificationManager.authorizationStatusHandlers(enabledHandler: {[unowned self]  () in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm a"
                self.timeLabel.text = "Notify me at " + dateFormatter.string(from: notificationTime)
            },
                                                            disabledHandler: {[unowned self] () in
                self.timeLabel.text = "Notifications are disabled"
            })
        } else {
            timeLabel.text = "No notifications"
        }
    }
}
