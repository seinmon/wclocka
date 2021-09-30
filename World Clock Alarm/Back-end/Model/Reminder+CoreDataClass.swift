/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData

@objc(Reminder)
public class Reminder: NSManagedObject {

}

extension Reminder: SelfManagedObject {
    func write(_ data: Any) {
        guard let entry = data as? Reminder else {
            return
        }

        self.timezone = entry.timezone
        self.title = entry.title
        self.details = entry.details
        self.notificationTime = entry.notificationTime
        self.reoccuring = entry.reoccuring
    }
}
