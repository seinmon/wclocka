//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit
import CoreData

class BaseTableViewController: UITableViewController {
    
    private var cellIdentifier: String?
    private var presenter: Presenter?
    private var dataSource: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    public func initialize(presenter: Presenter,
                           dataSource: NSFetchedResultsController<NSFetchRequestResult>) {
        self.presenter = presenter
        self.dataSource = dataSource
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return dataSource?.sections?[section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ?? "", for: indexPath)

        guard let cellConfigurable = cell as? CellConfigurable else {
            fatalError("Cell cannot be configured")
        }

        cellConfigurable.configure()
        
        return cell
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    private func setupTableView() {
        self.clearsSelectionOnViewWillAppear = false
        tableView.tableFooterView = UIView()
    }
}

extension BaseTableViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}

