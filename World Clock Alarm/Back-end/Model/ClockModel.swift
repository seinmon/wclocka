/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import UIKit

class ClockModel {
    private let timezone: TimeZone
    var timezoneTitle: String
    
    var dateDifference: String {
        return getOffset(of: timezone)
    }
    
    var time: String {
        return getTime(at: timezone)
    }
    
    init(title: String, timezone: TimeZone) {
        self.timezone = timezone
        self.timezoneTitle = title
    }
    
    private func getOffset(of timezone: TimeZone) -> String {
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
    
    private func getTime(at timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: Date())
    }
    
    deinit {
        debugPrint("ClockModel dinit")
    }
}

extension ClockModel: Equatable {
    static func == (lhs: ClockModel, rhs: ClockModel) -> Bool {
        return lhs.timezoneTitle == rhs.timezoneTitle
    }
}
