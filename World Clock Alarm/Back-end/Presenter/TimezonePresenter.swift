/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation

class TimezonePresenter {
    typealias TimezoneDictionary = [String: [String]]
    
    //MARK: - Properties
    
    let coordinator: Coordinator
    var dataSource: [TimezoneSection] = []
    
    // TODO: See if you can replace it with a dictionary of [String: [String]] and a sort function.
    struct TimezoneSection {
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
    
    //MARK: - Functions
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
        populateDataSource()
    }
    
    private func populateDataSource() {
        let timezoneDict = makeTimezoneDict()
        
        for item in timezoneDict {
            let timezoneSection = TimezoneSection(sectionTitle: item.key,
                                                  RowTitles: item.value)
            dataSource.append(timezoneSection)
        }
        
        dataSource.sort { $0.sectionTitle < $1.sectionTitle }
    }
    
    private func makeTimezoneDict() -> TimezoneDictionary {
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
    
    deinit {
        debugPrint("timezone presenter is being deinitialized")
    }
}

extension TimezonePresenter: Presenter {
    typealias DataSourceElement = String
    
    subscript(indexPath: IndexPath) -> Any {
        get {
            dataSource[indexPath.section].RowTitles[indexPath.row]
        }
    }
    
    func getSectionCount() -> Int {
        return dataSource.count
    }
    
    func getSectionHeaderTitle(for section: Int) -> String? {
        return dataSource[section].sectionTitle
    }
    
    func getSectionIndexTitles() -> [String]? {
        var sectionTitles: [String] = []
        
        for index in 0..<dataSource.count {
            guard let sectionHeader = getSectionHeaderTitle(for: index) else {
                continue
            }
            
            sectionTitles.append(sectionHeader)
        }
        
        return sectionTitles
    }
    
    func getRowCount(inSection section: Int) -> Int {
        return dataSource[section].RowTitles.count
    }
    
    func didSelectBarButtonItem() {
        coordinator.start()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        // TODO: Send the element(s) necessary to create world clock items.
        coordinator.start(with: self[indexPath])
    }
}
