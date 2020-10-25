//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class WorldClockTableViewCell: UITableViewCell, CellConfigurable {
    typealias DataSourceElement = String
    
    static var cellId: String = "TimezoneCell"
    @IBOutlet weak var timezoneTitle: UILabel!
    @IBOutlet weak var dateDifference: UILabel!
    @IBOutlet weak var timeDifference: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var AMPMLabel: UILabel!
    
    func configure(with data: DataSourceElement) {
        
    }
}
