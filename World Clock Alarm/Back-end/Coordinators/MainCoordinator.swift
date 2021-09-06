/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController {get set}
    func coordinate(data: Any?)
}

class MainCoordinator: Coordinator {
    typealias CoordinationData = Void
    weak var window: UIWindow?

    lazy var navigationController: UINavigationController = {
        let rootViewController = UIStoryboard
            .instantiateInitialViewController(of: StoryboardName.worldClock)
        rootViewController.coordinator = WorldClockCoordinator(parentCoordinator: self)
        
        return UINavigationController(rootViewController: rootViewController)
    }()
    
    init(window: UIWindow?) {
        self.window = window
        self.coordinate()
    }
    
    func coordinate(data: Any? = nil) {
        window?.rootViewController = navigationController
        
        if #available(iOS 13, *) {
            window?.backgroundColor = UIColor.systemBackground
        } else {
            window?.backgroundColor = UIColor.white
        }
        
        window?.makeKeyAndVisible()
    }
}
