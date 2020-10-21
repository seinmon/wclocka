/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation

struct TimezonePresenter: Presenter {
    typealias TimezoneDictionary = [String: [String]]
    
    //MARK: - Properties
    
    var dataSource: [SectionedTimezone] = []

    var sectionIndexTitles: [String] {
        var sectionTitles: [String] = []
        
        for index in 0..<dataSource.count {
            sectionTitles.append(self[index])
        }
        
        return sectionTitles
    }
    
    struct SectionedTimezone {
        let sectionTitle: String
        var RowTitles: [String]
        
        init(sectionTitle: String, RowTitles: [String]) {
            self.sectionTitle = sectionTitle
            self.RowTitles = RowTitles
            sortRows()
        }
        
        mutating func sortRows() {
            RowTitles.sort(by: <)
        }
    }
    
    //MARK: - Subscripts
    
    subscript(section: Int) -> String {
        dataSource[section].sectionTitle
    }
    
    subscript(indexPath: IndexPath) -> String {
        dataSource[indexPath.section].RowTitles[indexPath.row]
    }
    
    //MARK: - Functions
    
    init() {
        populateDataSource()
    }
    
    func getSectionCount() -> Int {
        dataSource.count
    }
    
    func getRowCount(inSection section: Int) -> Int {
        dataSource[section].RowTitles.count
    }
    
    mutating func populateDataSource() {
        let timezoneDict = makeTimezoneDict()
        for item in timezoneDict {
            let sectionedTimezone = SectionedTimezone(sectionTitle: item.key,
                                                      RowTitles: item.value)
            dataSource.append(sectionedTimezone)
        }
        
        dataSource.sort { $0.sectionTitle < $1.sectionTitle }
    }
    
    func makeTimezoneDict() -> TimezoneDictionary {
        var timezoneDict: TimezoneDictionary = [:]
        
        for timeZone in TimeZone.knownTimeZoneIdentifiers {
            if let cityOptional = timeZone.split(separator: "/").last {
                var city = String(cityOptional)
                let key: String = String(city.prefix(1))
                
                city = city.replacingOccurrences(of: "_", with: " ")
                
                if timezoneDict[key]?.append(city) == nil {
                    timezoneDict[key] = [city]
                }
            }
        }
        
        return timezoneDict
    }
}
