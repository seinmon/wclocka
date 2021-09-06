/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

/* Read for documentation here:
 * https://valv0.medium.com/computed-properties-and-extensions-a-pure-swift-approach-64733768112c
 *
 * This causes a little bit of scattering, but if I wanted to put coordinator inside the presenters,
 * then I would have to downcast the tableViewController classes. */
extension UIViewController {
    private static var computedCoordinator = [String : Coordinator]()
        
    var coordinator: Coordinator? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIViewController.computedCoordinator[tmpAddress] ?? nil
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIViewController.computedCoordinator[tmpAddress] = newValue
        }
    }
}
