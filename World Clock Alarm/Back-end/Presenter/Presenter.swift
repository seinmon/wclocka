//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation

protocol Presenter {

//    var dataSource: [String] { get set }
    var sectionCount: Int { get }
    var rowCount: Int { get }
}
