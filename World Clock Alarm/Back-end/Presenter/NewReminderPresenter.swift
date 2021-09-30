/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class NewReminderPresenter {
    internal let coordinator: Coordinator
    internal let viewController: UIViewController
    
    init(coordinator: Coordinator,
         controller: UIViewController) {
        self.coordinator = coordinator
        self.viewController = controller
    }
}

/*
extension NewReminderPresenter: Presenter {
    var viewController: UIViewController {
        <#code#>
    }
    
    var coordinator: Coordinator {
        <#code#>
    }
    
    subscript(indexPath: IndexPath) -> Any {
        <#code#>
    }
    
    func getSectionCount() -> Int {
        <#code#>
    }
    
    func getRowCount(inSection section: Int) -> Int {
        <#code#>
    }
    
    
}
 
*/
