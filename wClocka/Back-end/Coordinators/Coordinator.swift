/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

/**
 * Implements the navigation and data tramission between view controllers.
 */
protocol Coordinator: AnyObject {

    /**
     * Holds a reference to the coordinator that started current view controller.
     * It is useful for backward navigation and accessing the main UINavigationController of the application.
     */
    var parentCoordinator: Coordinator? {get set}

    /**
     * An interface that receives updates from coordinator events.
     * Updates are usually used to react to the movement between view controllers.
     */
    var delegate: CoordinatorDelegate? {get set}
    var navigationController: UINavigationController? {get set}
    init(parentCoordinator: Coordinator)
    func start(with data: Any?)
}

extension Coordinator {
    // swiftlint:disable unused_setter_value
    var navigationController: UINavigationController? {
        get {
            parentCoordinator?.navigationController
        } set { }
    }

    func start(with data: Any?) { }
}

protocol CoordinatorDelegate: AnyObject {
    func didReceiveNewData(_ data: Any)
    func didMoveBackwardsWithNoData()
}

extension CoordinatorDelegate {
    func didMoveBackwardsWithNoData() { }
}
