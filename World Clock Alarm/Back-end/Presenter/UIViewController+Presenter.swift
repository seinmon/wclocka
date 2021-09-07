/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

/* This avoids the need to downcast tableViewController classes, which would result in a lot of
 * code replication.
 *
 * Documentation is here:
 * https://valv0.medium.com/computed-properties-and-extensions-a-pure-swift-approach-64733768112c */
extension UIViewController {
    private static var computedPresenter = [String : Presenter]()
    
    var presenter: Presenter? {
        get {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            return UIViewController.computedPresenter[tmpAddress] ?? nil
        }
        set(newValue) {
            let tmpAddress = String(format: "%p", unsafeBitCast(self, to: Int.self))
            UIViewController.computedPresenter[tmpAddress] = newValue
        }
    }
}
