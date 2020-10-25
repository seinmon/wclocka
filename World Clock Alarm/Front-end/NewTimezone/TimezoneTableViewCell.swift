//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class TimezoneTableViewCell: UITableViewCell, CellConfigurable {
    typealias DataSourceElement = String
    
    static var cellId: String = "NewTimezoneCell"
    @IBOutlet weak var timezoneTitle: UILabel!
    
    func configure(with text: DataSourceElement) {
        timezoneTitle.text = text
    }
}
