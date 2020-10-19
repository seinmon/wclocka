/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

protocol Coordinator { }

class MainCoordinator: Coordinator {
    
    weak var windor: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        let storyboard = UIStoryboard(name: "NewTimezone", bundle: .main)
        let viewController = storyboard
            .instantiateInitialViewController() as? TimezoneTableViewController
        
        guard let initialViewController = viewController else {
            fatalError("Failed to instantiate initial view controller in MainCoordinato")
        }
        
        initialViewController.initialize(cellIdentifier: "NewTimezoneCell",
                                         presenter: TimezonePresenter())
        
        return UINavigationController(rootViewController: initialViewController)
    }()
    
    init(window: UIWindow?) {
        guard let window = window else {
            fatalError("Window is not initialized")
        }
        
        start(window)
    }
    
    private func start(_ window: UIWindow) {
        
        window.rootViewController = rootViewController
        
        if #available(iOS 13, *) {
            window.backgroundColor = UIColor.systemBackground
        } else {
            window.backgroundColor = UIColor.white
        }
        
        window.makeKeyAndVisible()
    }
}
