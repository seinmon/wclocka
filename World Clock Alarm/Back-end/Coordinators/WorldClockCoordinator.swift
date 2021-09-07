/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockCoordinator: ChildCoordinator {
    override func start() {
        let timezoneViewController =
            UIStoryboard.instantiateInitialViewController(of: StoryboardName.timezone)
        
        let timezoneCoordinator = TimezoneCoordinator(parentCoordinator: self)
        let timezonePresenter = TimezonePresenter(coordinator: timezoneCoordinator)
        
        timezoneViewController.presenter = timezonePresenter
        
        let timezoneNavigationController = UINavigationController(rootViewController:
                                                                    timezoneViewController)
        
        navigationController.present(timezoneNavigationController, animated: true)
    }
    
    override func start(with data: Any) {
        // TODO: Start reminders from here
    }
}
