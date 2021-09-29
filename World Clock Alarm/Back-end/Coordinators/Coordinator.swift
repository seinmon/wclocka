/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var delegate: CoordinatorDelegate? {get set}
    var splitViewController: UISplitViewController {get set}
    func start()
    func start(with data: Any)
}

protocol CoordinatorDelegate: AnyObject {
    func didReceiveNewData(_ data: Any)
}
