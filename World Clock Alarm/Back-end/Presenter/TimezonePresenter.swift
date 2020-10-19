/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation
import os.log

struct TimezonePresenter: Presenter {
    var dataSource = [String: [String]]()
    
    var sectionCount: Int {
        return dataSource.keys.count
    }
    
    var rowCount: Int {
        return dataSource.count
    }
    
    init() {
        populateDataSource()
    }
    
    mutating func populateDataSource() {
        for timeZone in TimeZone.knownTimeZoneIdentifiers {
            if let cityOptional = timeZone.split(separator: "/").last {
                var city = String(cityOptional)
                let key: String = String(city.prefix(1))
                
                city = city.replacingOccurrences(of: "_", with: " ")
                
                if dataSource[key]?.append(city) == nil {
                    dataSource[key] = [city]
                }
            }
        }
        
        print(dataSource)
    }
}
