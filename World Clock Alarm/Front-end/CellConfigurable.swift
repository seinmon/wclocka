//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

protocol CellConfigurable {
    func configure(with data: NSFetchRequestResult)
    func configure(with text: String)
}

extension CellConfigurable {
    func configure(with data: NSFetchRequestResult) { }
    func configure(with text: String) { }
}

