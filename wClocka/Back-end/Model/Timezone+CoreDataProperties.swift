/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData


extension Timezone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timezone> {
        return NSFetchRequest<Timezone>(entityName: "Timezone")
    }

    @NSManaged public var zoneIdentifier: String
    @NSManaged public var zoneTitle: String
    @NSManaged public var reminders: NSSet?

}

// MARK: Generated accessors for reminders
extension Timezone {

    @objc(addRemindersObject:)
    @NSManaged public func addToReminders(_ value: Reminder)

    @objc(removeRemindersObject:)
    @NSManaged public func removeFromReminders(_ value: Reminder)

    @objc(addReminders:)
    @NSManaged public func addToReminders(_ values: NSSet)

    @objc(removeReminders:)
    @NSManaged public func removeFromReminders(_ values: NSSet)

}
