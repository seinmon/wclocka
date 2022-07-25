/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class ReminderDetailsTableViewController: BaseTableViewController {

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setBackgroundColor()
        tableView.reloadData()
    }

    private func setBackgroundColor() {
        if #available(iOS 13, *) {
            if traitCollection.userInterfaceStyle == .dark {
                tableView.backgroundColor = .systemBackground
            } else {
                tableView.backgroundColor = .secondarySystemBackground
            }
        } else {
            tableView.backgroundColor = UIColor(red: 242.0, green: 242.0, blue: 247.0, alpha: 1)
        }
    }

    override func tableView(_ tableView: UITableView,
                            willDisplay cell: UITableViewCell,
                            forRowAt indexPath: IndexPath) {
        if #available(iOS 13, *) {
            if traitCollection.userInterfaceStyle == .dark {
                cell.backgroundColor = .secondarySystemBackground
            } else {
                cell.backgroundColor = .systemBackground
            }
        } else {
            cell.backgroundColor = .white
        }

        if indexPath.section != 3 {
            cell.selectionStyle = .none
        }
    }

    override func setupNavigationBar() {
        title = presenter?.viewControllerTitle
        self.navigationItem
            .rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                  target: self,
                                                  action: #selector(didSelectPrimaryBarButtonItem))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                                target: self,
                                                                action: #selector(cancel))
        tableViewStateDidChange()
    }

    @objc
    override func cancel() {
        presenter?.dismissCompletion()
        dismiss(animated: true)
    }

    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        return 4
    }
}
