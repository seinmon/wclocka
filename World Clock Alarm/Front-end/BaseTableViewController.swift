/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit
import CoreData

class BaseTableViewController: UITableViewController {
    
    var cellIdentifier: String?
    var presenter: Presenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    public func initialize(cellIdentifier: String,
                           presenter: Presenter?) {
        self.cellIdentifier = cellIdentifier
        self.presenter = presenter
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.sectionCount ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return presenter?.rowCount ?? 0
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ?? "",
                                                 for: indexPath)

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

