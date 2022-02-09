/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class WorldClockTableViewController: BaseTableViewController, ContextualActionOwner {

    override public func tableViewStateDidChange() {
        super.tableViewStateDidChange()
        if (presenter?.dataSourceIsEmpty ?? false) {
            self.navigationItem.leftBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = self.editButtonItem
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
        if ((presenter?.showDeletionWarning(indexPath: indexPath) ?? false)) {
            let alert = UIAlertController(title: "Delete Time Zone?",
                                          message: "This action will delete this time zone and its reminders.",
                                          preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {[unowned self] _ in
                self.presenter?.deleteFromDataSource(indexPath: indexPath)
            }
            
            alert.addAction(deleteAction)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
            
        } else {
            presenter?.deleteFromDataSource(indexPath: indexPath)
        }
    }
}
