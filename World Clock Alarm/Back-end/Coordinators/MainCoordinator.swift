/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

protocol Coordinator { }

struct MainCoordinator: Coordinator {
    weak var windor: UIWindow?
    
    lazy var rootViewController: UINavigationController = {
        let rootViewController = UIStoryboard
            .instantiateInitialViewController(of: StoryboardName.worldClock)
        return UINavigationController(rootViewController: rootViewController)
    }()
    
    init(window: UIWindow?) {
        if let window = window {
            start(window)
        }
    }
    
    private mutating func start(_ window: UIWindow) {
        window.rootViewController = rootViewController
        
        if #available(iOS 13, *) {
            window.backgroundColor = UIColor.systemBackground
        } else {
            window.backgroundColor = UIColor.white
        }
        
        window.makeKeyAndVisible()
    }
}
