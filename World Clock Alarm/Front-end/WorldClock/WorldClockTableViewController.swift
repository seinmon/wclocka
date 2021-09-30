/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockTableViewController: BaseTableViewController<WorldClockTableViewCell>,
                                     ContextualActionOwner {
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        title = "World Clocks"
    }
    
    // TODO: Delete after implementing reminders
    override func setupTableView() {
        super.setupTableView()
    }

    override public func activateEditButton() {
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
    
    /*
    override func setupContextualActions(for indexPath: IndexPath) -> [UIContextualAction] {
        var actions = super.setupContextualActions(for: indexPath)
        actions.append(UIContextualAction(style: .normal,
                                          title: "Rename",
                                          handler: { [unowned self] (_, _, _) in
                                            guard let presenter = self.presenter else {
                                                return
                                            }
                                            
                                            // TODO: present an alert with textField to change title
                                            
                                            presenter.updateDataSource(at: indexPath, to: newTitle)
                                          }))
        return actions
    }
    */
    
    func didSelectDeleteAction(for indexPath: IndexPath) {
        if (!(presenter?.deleteFromDataSource(indexPath: indexPath) ?? true)) {
            //TODO: Show Alert if there are reminders for that timezone
        }
    }
}
