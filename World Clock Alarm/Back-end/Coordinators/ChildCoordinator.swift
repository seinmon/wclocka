/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

protocol SubCoordinator: Coordinator {
    var parentCoordinator: Coordinator? {get set}
}

class ChildCoordinator: SubCoordinator {
    weak var delegate: CoordinatorDelegate?
    weak var parentCoordinator: Coordinator?
//    var splitViewController: UISplitViewController? {
    var navigationController: UINavigationController? {
        get {
//            parentCoordinator?.splitViewController
            parentCoordinator?.navigationController
        } set { }
    }

    init(parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    func start(with data: Any) { }
    func start() { }
    
    deinit {
        debugPrint("ChildCoordinator is being deinitialized")
    }
}
