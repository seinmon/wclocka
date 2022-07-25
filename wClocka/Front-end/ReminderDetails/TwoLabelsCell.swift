/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class TwoLabelsCell: UITableViewCell, CellConfigurable {

    @IBOutlet weak var timeZoneTitle: UILabel!
    @IBOutlet weak var timeZoneOffset: UILabel!

    func configure(with data: Any) {
        guard let data = data as? ReminderDetailsCell else {
            return
        }

        timeZoneTitle.text = data.0.timezone?.zoneTitle
        timeZoneOffset.text = data.0.timezone?.timeOffset
    }
}
