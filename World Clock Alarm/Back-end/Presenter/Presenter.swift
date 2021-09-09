/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

protocol Presenter: AnyObject {
    var coordinator: Coordinator { get }
    var allowsEditing: Bool { get }
    subscript(indexPath: IndexPath) -> Any { get }
    init(coordinator: Coordinator)
    func getSectionCount() -> Int
    func getSectionHeaderTitle(for section: Int) -> String?
    func getSectionIndexTitles() -> [String]?
    func getRowCount(inSection section: Int) -> Int
    func didSelectBarButtonItem()
    func didSelectRow(at indexPath: IndexPath)
    func filterDataSource(text: String?)
    func deleteFromDataSource(indexPath: IndexPath) -> Bool
    func updateDataSource(at indexPath: IndexPath, to data: Any)
}

extension Presenter {
    var allowsEditing: Bool { false }
    func getSectionHeaderTitle(for section: Int) -> String? { nil }
    func getSectionIndexTitles() -> [String]? { nil }
    func didSelectRow(at indexPath: IndexPath) { }
    func didSelectBarButtonItem() { }
    func filterDataSource(text: String?) { }
    func deleteFromDataSource(indexPath: IndexPath) -> Bool { return false }
    func updateDataSource(at indexPath: IndexPath, to data: Any) { }
}
