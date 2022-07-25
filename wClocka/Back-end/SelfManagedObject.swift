/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

/**
 * An interface to functionalities that are specific to a managed object
 */
protocol SelfManagedObject: NSManagedObject {
    /**
     * Provide the write functionality for DatabaseTransactionManager
     *
     * - Parameters:
     *  - data: Data to write
     */
    func write(_ data: Any)

    /**
     * Provide the write functionality for DatabaseTransactionManager
     *
     * - Parameters:
     *  - newData: New data to update the entry in the database
     */
    func update(to newData: Any)
}
