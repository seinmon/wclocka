/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockTableViewCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var timezoneTitle: UILabel!
    @IBOutlet weak var dateDifference: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var timer: CADisplayLink?
    weak var data: Timezone?
    
    func configure(with data: Any) {
        guard let receivedData = data as? Timezone else {
            return
        }
        
        /*
        // TODO: Uncomment and test this statement after implementing rename functionality
        guard self.data != receivedData else {
            return
        }
        */
        
        if timer != nil {
            timer?.invalidate()
        }
        
        self.data = receivedData
        update()
        
        timer = CADisplayLink(target: self, selector: #selector(update))
        timer?.add(to: .current, forMode: .common)
    }
    
    @objc
    func update() {
            self.timezoneTitle.text = data?.zoneTitle
            self.dateDifference.text = data?.timeOffset
            self.timeLabel.text = data?.time
    }
}
