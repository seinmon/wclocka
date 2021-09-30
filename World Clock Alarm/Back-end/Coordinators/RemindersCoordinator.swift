/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class RemindersCoordinator: ChildCoordinator {
    override func start() {
        let newReminderViewController = UIStoryboard
            .instantiateInitialViewController(of: .newReminder)
        
        let newReminderCoordinator = NewReminderCoordinator(parentCoordinator: self)
        let newRemindersPresenter = NewReminderPresenter(coordinator: newReminderCoordinator,
                                                       controller: newReminderViewController)
//        newReminderViewController.presenter = newReminderViewController
        
//        let newReminderNavigationController = UINavigationController(rootViewController:
//                                                                    newReminderViewController)
//        newRemindersPresenter.viewController.modalPresentationStyle = .overCurrentContext
        
//        debugPrint(splitViewController?.viewControllers.count)
        
        navigationController?.present(newReminderViewController, animated: true)
//        guard let detailsViewController = splitViewController?.viewControllers[1] else {
//            debugPrint("Else")
//            return
//        }
        
//        detailsViewController.definesPresentationContext = true
//        detailsViewController.present(newReminderNavigationController,
//                                     animated: true, completion: nil)
    }
    
}
