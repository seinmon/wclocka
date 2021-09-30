/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockCoordinator: ChildCoordinator {
    override func start() {
        let timezoneViewController = UIStoryboard.instantiateInitialViewController(of: .timezone)
        
        let timezoneCoordinator = TimezoneCoordinator(parentCoordinator: self)
        let timezonePresenter = TimezonePresenter(coordinator: timezoneCoordinator,
                                                  controller: timezoneViewController)
        timezoneViewController.presenter = timezonePresenter
        
        let timezoneNavigationController = UINavigationController(rootViewController:
                                                                    timezoneViewController)
        
        /*
        timezoneNavigationController.modalPresentationStyle = .overCurrentContext
        
        guard let masterViewController = splitViewController?.viewControllers[0] else {
            return
        }
        
        masterViewController.definesPresentationContext = true
        masterViewController.present(timezoneNavigationController, animated: true, completion: nil)
        */
        
        navigationController?.present(timezoneNavigationController, animated: true)
    }
    
    override func start(with data: Any) {
        guard let data = data as? Timezone else {
            return
        }
        
        let remindersViewController = UIStoryboard.instantiateInitialViewController(of: .reminders)
        
        let remindersCoordinator = RemindersCoordinator(parentCoordinator: self)
        let remindersPresenter = RemindersPresenter(timezone: data,
                                                    coordinator: remindersCoordinator,
                                                    controller: remindersViewController)
        remindersViewController.presenter = remindersPresenter
        
        remindersViewController.modalPresentationStyle = .overFullScreen
        navigationController?.pushViewController(remindersViewController, animated: true)
        
        /*
        guard let masterViewController = splitViewController?.viewControllers[0] else {
            return
        }
        
//        splitViewController?.viewControllers[1] = detailViewController
//        splitViewController?.showDetailViewController(remindersNavigationController,
//                                                      sender: masterViewController)
        
        if let top = masterViewController.navigationController?.topViewController,
           top != masterViewController {
            if let navController = splitViewController?.viewControllers[0] as? UINavigationController {
                navController.popViewController(animated: false)
                DispatchQueue.main.async {
                    self.splitViewController?.showDetailViewController(remindersNavigationController,
                                                                 sender: masterViewController)
                }
                return
            }
        }
        
        splitViewController?.showDetailViewController(remindersNavigationController,
                                                     sender: masterViewController)
        */
    }
}
