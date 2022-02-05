/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var delegate: CoordinatorDelegate?
    weak var window: UIWindow?
    
    /*
    lazy var splitViewController: UISplitViewController? = {
        let splitViewController = PrimarySplitViewController()
        splitViewController.viewControllers = initializeViewControllers()
        
        if #available(iOS 13, *) {
            splitViewController.primaryBackgroundStyle = .sidebar
        }
        
        return splitViewController
    }()
    */
    
    lazy var navigationController: UINavigationController? = {
        let worldClockController = UIStoryboard.instantiateInitialViewController(of: .worldClock)
        let worldClockCoordinator = WorldClockCoordinator(parentCoordinator: self)
        let worldClockPresenter = WorldClockPresenter(coordinator: worldClockCoordinator,
                                                      controller: worldClockController)
        
        worldClockController.presenter = worldClockPresenter
        worldClockCoordinator.delegate = worldClockPresenter
        return UINavigationController(rootViewController: worldClockController)
        
    }()
    
    init(window: UIWindow?) {
        self.window = window
        self.start()
    }
    
    func start(with data: Any) {}
    
    func start() {
        window?.rootViewController = navigationController //splitViewController
        window?.backgroundColor = UIColor.black
        window?.makeKeyAndVisible()
    }
    
    /*
    private func initializeViewControllers() -> [UIViewController] {
        /// Initialize masterViewController
        let worldClockController = UIStoryboard.instantiateInitialViewController(of: .worldClock)
        let worldClockCoordinator = WorldClockCoordinator(parentCoordinator: self)
        let worldClockPresenter = WorldClockPresenter(coordinator: worldClockCoordinator,
                                                      controller: worldClockController)
        
        worldClockCoordinator.delegate = worldClockPresenter
        worldClockController.presenter = worldClockPresenter
        
        let masterNavigationController = UINavigationController(rootViewController:
                                                                worldClockController)
        
        /// Initialize detailsViewController
        let remindersController = UIStoryboard.instantiateInitialViewController(of: .reminders)
        let remindersCoordinator = WorldClockCoordinator(parentCoordinator: worldClockCoordinator)
        let remindersPresenter = WorldClockPresenter(coordinator: remindersCoordinator,
                                                      controller: remindersController)
        
        remindersCoordinator.delegate = remindersPresenter
        remindersController.presenter = remindersPresenter
        
        let detailsNavigationController = UINavigationController(rootViewController:
                                                                remindersController)
        
        return [masterNavigationController, detailsNavigationController]
    }
     */
}
