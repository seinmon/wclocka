/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import UIKit

class TextFieldCell: UITableViewCell, CellConfigurable, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    weak var dataSource: ReminderViewModel?
    weak var viewController: UIViewController?
    var indexPath: IndexPath?

    func configure(with data: Any) {
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                            for: .editingChanged)

        guard let data = data as? ReminderDetailsCell else {
            return
        }

        dataSource = data.0
        viewController = data.2

        textField.delegate = self
        textField.placeholder = "Reminder title"

        if !(dataSource?.title.isEmpty ?? true) {
            textField.text = dataSource?.title
        }

        toggleSaveButton()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @objc
    func textFieldDidChange(_ sender: UITextField) {
        if let text = sender.text {
            dataSource?.title = text
        }

        toggleSaveButton()
    }

    private func toggleSaveButton() {
        viewController?.navigationItem.rightBarButtonItem?
            .isEnabled = !(textField.text?.isEmpty ?? false)
    }
}
