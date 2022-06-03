/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit
import CoreData

protocol Presenter: AnyObject {
    var viewController: UIViewController { get }
    var viewControllerTitle: String { get }
    var coordinator: Coordinator { get }
    var dataSourceIsEmpty: Bool { get }
    subscript(indexPath: IndexPath) -> Any { get }
    init(coordinator: Coordinator, controller: UIViewController)
    func getSectionCount() -> Int
    func getSectionHeaderTitle(for section: Int) -> String?
    func getSectionIndexTitles() -> [String]?
    func getRowCount(inSection section: Int) -> Int
    func getCellReusableIdentifier(for indexPath: IndexPath) -> String
    func didSelectBarButtonItem()
    func didSelectRow(at indexPath: IndexPath)
    func filterDataSource(text: String?)
    func showDeletionWarning(indexPath: IndexPath) -> Bool
    func deleteFromDataSource(indexPath: IndexPath)
    func updateDataSource(at indexPath: IndexPath, to data: Any)
    func dismissCompletion()
}

extension Presenter {
    var dataSourceIsEmpty: Bool { false }
    var viewControllerTitle: String { "" }
    func getSectionHeaderTitle(for section: Int) -> String? { nil }
    func getSectionIndexTitles() -> [String]? { nil }
    func didSelectRow(at indexPath: IndexPath) { }
    func didSelectBarButtonItem() { coordinator.start(with: nil) }
    func filterDataSource(text: String?) { }
    func showDeletionWarning(indexPath: IndexPath) -> Bool { return false }
    func deleteFromDataSource(indexPath: IndexPath) { }
    func updateDataSource(at indexPath: IndexPath, to data: Any) { }
    func dismissCompletion() { }
}

/**
 * A presenter with core data as its data source
 *
 * Presenter protocol has the basic functionality a presenter needs to offer, but it does not include
 * CoreData as a persistent container. If the use of CoreData is needed, then presenters
 * should conform to CoreDataPresenter, thereby adding default coreData functionality. */
protocol CoreDataPresenter: Presenter {
    associatedtype Model: SelfManagedObject
    var dataSource: NSFetchedResultsController<Model>? { get set }
}

extension CoreDataPresenter {
    internal var dataSourceIsEmpty: Bool {
        return (dataSource?.fetchedObjects?.isEmpty ?? true)
    }

    subscript(indexPath: IndexPath) -> Any {
        get {
            return dataSource?.fetchedObjects?[indexPath.row] as Any
        }
    }
    
    func getSectionCount() -> Int {
        return dataSource?.sections?.count ?? 0
    }
    
    func getRowCount(inSection section: Int) -> Int {
        dataSource?.fetchedObjects?.count ?? 0
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: self[indexPath])
    }
}
