/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var delegate: CoordinatorDelegate?
    weak var window: UIWindow?

    lazy var navigationController: UINavigationController = {
        let worldClockController = UIStoryboard
            .instantiateInitialViewController(of: StoryboardName.worldClock)
        let worldClockCoordinator = WorldClockCoordinator(parentCoordinator: self)
        let worldClockPresenter = WorldClockPresenter(coordinator: worldClockCoordinator)
        
        worldClockCoordinator.delegate = worldClockPresenter
        worldClockController.presenter = worldClockPresenter
        
        return UINavigationController(rootViewController: worldClockController)
    }()
    
    init(window: UIWindow?) {
        self.window = window
        self.start()
    }
    
    func start(with data: Any) {}
    
    func start() {
        window?.rootViewController = navigationController
        window?.backgroundColor = UIColor.black
        window?.makeKeyAndVisible()
    }
}
