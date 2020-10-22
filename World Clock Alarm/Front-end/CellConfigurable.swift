//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

protocol CellConfigurable {
    associatedtype DataSourceElement
    static var cellId: String { get }
    func configure(with data: DataSourceElement)
}
