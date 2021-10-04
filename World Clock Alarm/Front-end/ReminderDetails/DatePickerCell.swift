/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class DatePickerCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var picker: UIDatePicker!
    weak var dataSource: ReminderViewModel?
    
    func configure(with data: Any) {
        guard let data = data as? ReminderDetailsCell else {
            return
        }
        
        dataSource = data.0
        
        if let notificationTime = dataSource?.notificationTime {
            picker.date = notificationTime
        }
    }
    
    @IBAction func valueDidChange(_ sender: UIDatePicker) {
        debugPrint("didChangeVal")
        dataSource?.notificationTime = picker.date
    }
    
}
