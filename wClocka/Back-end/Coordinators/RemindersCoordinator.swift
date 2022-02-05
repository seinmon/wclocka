/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersCoordinator: ChildCoordinator {
    override func start(with data: Any) {
        let reminderDetailsViewController = UIStoryboard
            .instantiateInitialViewController(of: .reminderDetails)
        
        let reminderDetailsCoordinator = ReminderDetailsCoordinator(parentCoordinator: self)
        let reminderDetailsPresenter = ReminderDetailsPresenter(data: data,
                                                         coordinator: reminderDetailsCoordinator,
                                                         controller: reminderDetailsViewController)
        reminderDetailsViewController.presenter = reminderDetailsPresenter
        
        let reminderDetailsNavigationController = UINavigationController(
            rootViewController: reminderDetailsViewController)
        
        navigationController?.present(reminderDetailsNavigationController, animated: true)
       
    }
}
