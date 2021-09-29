/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class TimezoneCoordinator: ChildCoordinator {
    
    override func start(with data: Any) {
        parentCoordinator.delegate?.didReceiveNewData(data)
    }
    
    deinit {
        debugPrint("timezone coordinator is being deinitialized")
    }
}
