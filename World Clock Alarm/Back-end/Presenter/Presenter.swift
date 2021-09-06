/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

protocol Presenter {
    associatedtype DataSourceElement
    init()
    subscript(indexPath: IndexPath) -> DataSourceElement { get }
    func getSectionCount() -> Int
    func getSectionHeaderTitle(for section: Int) -> String?
    func getSectionIndexTitles() -> [String]?
    func getRowCount(inSection section: Int) -> Int
    func coordinationIsNeeded(with coordinator: Coordinator?, for indexPath: IndexPath?)
}

extension Presenter {
    func getSectionHeaderTitle(for section: Int) -> String? { nil }
    func getSectionIndexTitles() -> [String]? { nil }
}
