/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

protocol SubCoordinator: Coordinator {
    var parentCoordinator: Coordinator {get set}
}

class ChildCoordinator: SubCoordinator {
    weak var delegate: CoordinatorDelegate?
    // TODO: ParentCoordinator must be weak, otherwise we'll have reference cycles
    var parentCoordinator: Coordinator
    var navigationController: UINavigationController {
        get {
            parentCoordinator.navigationController
        } set {
            parentCoordinator.navigationController = newValue
        }
    }

    init(parentCoordinator: Coordinator) {
        self.parentCoordinator = parentCoordinator
    }
    
    func start(with data: Any) { }
    func start() { }
    
    deinit {
        debugPrint("Coordinator is being deinitialized")
    }
}
