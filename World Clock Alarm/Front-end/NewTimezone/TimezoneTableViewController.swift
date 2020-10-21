//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class TimezoneTableViewController: BaseTableViewController {

    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        if let presenter = presenter as? TimezonePresenter {
            return presenter[section]
        }
        
        return ""
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard let presenter = presenter as? TimezonePresenter else {
            return nil
        }
        
        return presenter.sectionIndexTitles
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier ?? "",
                                                 for: indexPath)
        
        guard let cellConfigurable = cell as? CellConfigurable else {
            fatalError("Cell cannot be configured")
        }

        guard let presenter = presenter as? TimezonePresenter else {
            fatalError("Not a TimezonePresenter")
        }
        
        cellConfigurable.configure(with: presenter[indexPath])
        return cell
    }


    
    // MARK: - Navigation

}
