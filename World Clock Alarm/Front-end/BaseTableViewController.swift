/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit
import CoreData

protocol ContextualActionOwner: UITableViewController {
    func setupContextualActions(for indexPath: IndexPath) -> [UIContextualAction]
    func didSelectDeleteAction(for indexPath: IndexPath)
}

class BaseTableViewController<ConfigurableCell: CellConfigurable>: UITableViewController,
                                                                   NSFetchedResultsControllerDelegate {
    
    private var cellIdentifier: String = ConfigurableCell.cellId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    // MARK: - Table view
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (presenter?.getSectionCount() ?? 0)
    }
    
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        return presenter?.getSectionHeaderTitle(for: section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return presenter?.getSectionIndexTitles()
    }
    
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return (presenter?.getRowCount(inSection: section) ?? 0)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        
        guard let cellConfigurable = cell as? ConfigurableCell else {
            return cell
        }
        
        cellConfigurable.configure(with: presenter?[indexPath] as Any)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
    }
    
    // MARK: - Table view editing
    
    override func tableView(_ tableView: UITableView,
                            trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        guard let controller = self as? ContextualActionOwner else {
            return nil
        }
        
        return UISwipeActionsConfiguration(actions: controller.setupContextualActions(for: indexPath))
    }
    
    override func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        setEditing(false, animated: true)
    }
    
    // MARK: - Helpers
    //Override these methods in the subclasses if needed.
    
    public func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector((addNewItems)))
        activateEditButton()
    }
    
    private func activateEditButton() {
        if !(presenter?.dataSourceIsEmpty ?? true) {
            self.navigationItem.leftBarButtonItem = self.editButtonItem
            self.tableView.backgroundView = UIView()
        } else {
            self.navigationItem.leftBarButtonItem = nil
            let emptyLabel = UILabel(frame: UIScreen.main.bounds)
            emptyLabel.text = "Nothing to Show!"
            
            if #available(iOS 13, *) {
                emptyLabel.textColor = .tertiaryLabel
            } else {
                emptyLabel.textColor = .systemGray
            }
            
            emptyLabel.textAlignment = .center
            self.tableView.backgroundView = emptyLabel
        }
    }
    
    @objc
    public func addNewItems() {
        presenter?.didSelectBarButtonItem()
    }
    
    public func setupTableView() {
        self.clearsSelectionOnViewWillAppear = false
        let footerView = UIView()
        tableView.tableFooterView = footerView
    }
    
    public func setupContextualActions(for indexPath: IndexPath) -> [UIContextualAction] {
        return [UIContextualAction(style: .destructive,
                                   title: "Delete",
                                   handler: { [unowned self] (_, _, completion) in
                                    guard let owner = self as? ContextualActionOwner else {
                                        return
                                    }
                                    
                                    owner.didSelectDeleteAction(for: indexPath)
                                    completion(true)
                                   }
        )]
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        
        let index = indexPath ?? (newIndexPath ?? nil)
        guard let cellIndex = index else { return }
        
        switch type {
        case .insert:
            tableView.insertRows(at: [cellIndex], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [cellIndex], with: .left)
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        activateEditButton()
        tableView.endUpdates()
    }
}
