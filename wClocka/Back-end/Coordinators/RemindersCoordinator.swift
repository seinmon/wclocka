/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    weak var delegate: CoordinatorDelegate?

    required init(parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
    }

    func start(with data: Any? = nil) {
        guard let data = data else {
            return
        }

        // swiftlint:disable force_cast
        let reminderDetailsViewController = UIStoryboard
            .instantiateInitialViewController(of: .reminderDetails) as! BaseTableViewController

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
