/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var delegate: CoordinatorDelegate?
    weak var window: UIWindow?
    
    lazy var navigationController: UINavigationController? = {
        let worldClockController = UIStoryboard.instantiateInitialViewController(of: .worldClock)
        let worldClockCoordinator = WorldClockCoordinator(parentCoordinator: self)
        let worldClockPresenter = WorldClockPresenter(coordinator: worldClockCoordinator,
                                                      controller: worldClockController)
        
        worldClockController.presenter = worldClockPresenter
        worldClockCoordinator.delegate = worldClockPresenter
        return UINavigationController(rootViewController: worldClockController)
        
    }()
    
    /// Initialize the starting point of the application.
    init(window: UIWindow?) {
        self.window = window
        self.start()
    }
    
    required init(parentCoordinator: Coordinator) {
        self.parentCoordinator = nil
    }
    
    func start(with data: Any? = nil) {
        window?.rootViewController = navigationController //splitViewController
        window?.backgroundColor = UIColor.black
        window?.makeKeyAndVisible()
    }
}
