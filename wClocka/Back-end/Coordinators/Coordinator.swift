/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

/**
 * An interface to implement the navigation between view controllers.
 */
protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? {get set}
    var delegate: CoordinatorDelegate? {get set}
    var navigationController: UINavigationController? {get set}
    init(parentCoordinator: Coordinator)
    func start(with data: Any?)
}

extension Coordinator {
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
