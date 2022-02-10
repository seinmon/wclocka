/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import CoreData


public class Timezone: NSManagedObject {
    public var timezone: TimeZone! {
        TimeZone(identifier: zoneIdentifier)
    }
    
    @objc public var time: String {
        return getTime(at: timezone)
    }
    
    @objc public var timeOffset: String {
        return getOffset(of: timezone)
    }
    
    private func getOffset(of timezone: TimeZone?) -> String {
        guard let timezone = timezone else {
            return "error"
        }
        
        return getDateDifference(of: timezone) + ", " + getGMTOffset(of: timezone)
    }
    
    private func getDateDifference(of timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        dateFormatter.timeZone = timezone
        
        return dateFormatter.string(from: Date())
    }
    
    private func getGMTOffset(of timezone: TimeZone) -> String {
        let offset = timezone.secondsFromGMT() - TimeZone.current.secondsFromGMT()
        let offsetHours = offset/3600
        let offsetMinutes = abs(offset/60) % 60
        return String(format: "%+.2d:%.2d", offsetHours, offsetMinutes)
    }
    
    private func getTime(at timezone: TimeZone?) -> String {
        guard let timezone = timezone else {
            return "error"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: Date())
    }
}

extension Timezone: SelfManagedObject {
    func write(_ data: Any) {
        if let entry = data as? NewTimezoneRow {
            self.zoneIdentifier = entry.1.identifier
            self.zoneTitle = entry.0
            self.reminders = []
        } else if let entry = data as? Timezone {
            self.zoneIdentifier = entry.zoneIdentifier
            self.zoneTitle = entry.zoneTitle
            self.reminders = entry.reminders
        }
    }
    
    
    func update(to newData: Any) {
        guard let entry = newData as? String else {
            return
        }
        
        self.zoneTitle = entry
    }
}
