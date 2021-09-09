//
/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */
//

import Foundation
import CoreData


public class Timezone: NSManagedObject {
    lazy private var timezone = TimeZone(identifier: zoneIdentifier)
    
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
        let targetTimezoneHours = timezone.secondsFromGMT()/3600
        let targetTimezoneMinutes = abs(timezone.secondsFromGMT()/60) % 60
        
        let currentTimezoneHours = TimeZone.current.secondsFromGMT()/3600
        let currentTimezoneMinutes = abs(TimeZone.current.secondsFromGMT()/60) % 60
        return String(format: "%+.2d:%.2d",
                      (targetTimezoneHours - currentTimezoneHours),
                      (targetTimezoneMinutes - currentTimezoneMinutes))
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
    
    deinit {
        debugPrint("ClockModel dinit")
    }
}
