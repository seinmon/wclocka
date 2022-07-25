/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

extension UIStoryboard {
    static func instantiateInitialViewController(of storyboard: StoryboardName) -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard.rawValue, bundle: .main)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Failed to downcast initialViewController")
        }

        return initialViewController
    }
}
