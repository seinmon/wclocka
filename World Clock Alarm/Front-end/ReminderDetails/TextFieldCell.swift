/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class TextFieldCell: UITableViewCell, CellConfigurable {
    
    @IBOutlet weak var textField: UITextField!
    weak var dataSource: ReminderViewModel?
    weak var viewController: UIViewController?
    var indexPath: IndexPath?
    
    func configure(with data: Any) {
        var placeholder: String?
        var text: String?
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)
        
        guard let data = data as? ReminderDetailsCell else {
            return
        }
        
        dataSource = data.0
        indexPath = data.1
        viewController = data.2
        
        if (indexPath?.row == 0) {
            placeholder = "Reminder title"
            text = dataSource?.title
            
        } else if (indexPath?.row == 1) {
            placeholder = "Notes"
            text = dataSource?.details
        }
        
        textField.placeholder = placeholder
        
        if !(text?.isEmpty ?? true) {
            textField.text = text
        }
        
        toggleSaveButton()
    }
    
    @objc
    func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            if (indexPath?.row == 0) {
                dataSource?.title = text
            } else if (indexPath?.row == 1) {
                dataSource?.details = text
            }
        }
        
        toggleSaveButton()
    }
    
    private func toggleSaveButton() {
        if (indexPath?.row == 0) {
            viewController?.navigationItem.rightBarButtonItem?
                .isEnabled = !(textField.text?.isEmpty ?? false)
        }
    }
    
}
