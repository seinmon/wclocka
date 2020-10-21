/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

protocol Presenter {
    func getSectionCount() -> Int
    func getRowCount(inSection section: Int) -> Int
}

protocol CoreDataPresenter: Presenter {
    var dataSource: NSFetchedResultsController<NSFetchRequestResult> { get set }
}
