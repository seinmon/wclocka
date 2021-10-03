//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class SwitchCell: UITableViewCell, CellConfigurable {
    @IBOutlet weak var switchLabel: UILabel!
    
    @IBAction func Switch(_ sender: UISwitch) {
        
    }
    
    func configure(with data: Any) {
    }
}

