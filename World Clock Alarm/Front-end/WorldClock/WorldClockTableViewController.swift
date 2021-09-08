/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockTableViewController: BaseTableViewController<WorldClockTableViewCell> {
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "World Clocks"
    }
    
    // TODO: Delete after implementing reminders
    override func setupTableView() {
        super.setupTableView()
        tableView.allowsSelection = false
    }
}
