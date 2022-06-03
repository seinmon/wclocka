/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    weak var delegate: CoordinatorDelegate?
    
    required init(parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    func start(with data: Any? = nil) {
        if let data = data as? Timezone {
        
            let remindersViewController = UIStoryboard.instantiateInitialViewController(of: .reminders)
            
            let remindersCoordinator = RemindersCoordinator(parentCoordinator: self)
            let remindersPresenter = RemindersPresenter(timezone: data,
                                                        coordinator: remindersCoordinator,
                                                        controller: remindersViewController)
            remindersViewController.presenter = remindersPresenter
            remindersCoordinator.delegate = remindersPresenter
            
            remindersViewController.modalPresentationStyle = .overFullScreen
            navigationController?.pushViewController(remindersViewController, animated: true)

        } else {
            let timezoneViewController = UIStoryboard.instantiateInitialViewController(of:
                    .timezone)
            
            let timezoneCoordinator = TimezoneCoordinator(parentCoordinator: self)
            let timezonePresenter = TimezonePresenter(coordinator: timezoneCoordinator,
                                                      controller: timezoneViewController)
            timezoneViewController.presenter = timezonePresenter
            
            let timezoneNavigationController = UINavigationController(rootViewController:
                                                                        timezoneViewController)
            
            navigationController?.present(timezoneNavigationController, animated: true)
        }
    }
}
