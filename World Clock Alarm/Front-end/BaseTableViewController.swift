/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit
import CoreData

class BaseTableViewController<PresenterType: Presenter,
                              ConfigurableCell: CellConfigurable>: UITableViewController,
                                                                   NSFetchedResultsControllerDelegate {
    
    private var presenter: PresenterType = PresenterType()
    private var cellIdentifier: String = ConfigurableCell.cellId
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        presenter.getSectionCount()
    }

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        presenter.getSectionHeaderTitle(for: section)
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        presenter.getSectionIndexTitles()
    }

    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        presenter.getRowCount(inSection: section)
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath)
        
        guard let cellConfigurable = cell as? ConfigurableCell else {
            return cell
        }

        guard let dataSource =
                presenter[indexPath] as? ConfigurableCell.DataSourceElement else {
            return cell
        }
        
        cellConfigurable.configure(with: dataSource)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coordinator = self.coordinator {
            presenter.coordinationIsNeeded(with: coordinator, for: indexPath)
        }
    }
    
    // MARK: - Helpers
    
    //Override these methods in the subclasses if needed.
    public func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector((addNewItems)))
    }
    
    @objc
    public func addNewItems() {
        presenter.coordinationIsNeeded(with: coordinator! , for: nil)
    }
    
    public func setupTableView() {
        self.clearsSelectionOnViewWillAppear = false
        tableView.tableFooterView = UIView()
    }
 
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
