/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation

class TimezonePresenter {

    typealias rowContent = (String, TimeZone)
    typealias TimezoneDictionary = [String: [rowContent]]
    
    //MARK: - Properties
    let coordinator: Coordinator
    private var allData: [TimezoneSection] = []
    private var dataSource: [TimezoneSection] = []
    private var isFilteringDataSource: Bool = false
    
    struct TimezoneSection {
        let sectionTitle: String
        var timezones: [rowContent]
        
        init(sectionTitle: String, timezones: [rowContent]) {
            self.sectionTitle = sectionTitle
            self.timezones = timezones
            sortRows()
        }
        
        mutating func sortRows() {
            timezones.sort { $0.0 < $1.0 }
        }
//
//        func filter(text: String) -> Bool {
//            var timezones: [rowContent] = timezones.filter { (title, zone) in
//                return title.lowercased().contains(text.lowercased())
//            }
//
//            debugPrint(timezones)
//            return true
//        }
    }
    
    //MARK: - Functions
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
        populateAllData()
    }
    
    private func populateAllData() {
        let timezoneDict = makeTimezoneDict()
        
        for item in timezoneDict {
            let timezoneSection = TimezoneSection(sectionTitle: item.key,
                                                  timezones: item.value)
            allData.append(timezoneSection)
        }
        
        allData.sort { $0.sectionTitle < $1.sectionTitle }
        dataSource = allData
    }
    
    private func makeTimezoneDict() -> TimezoneDictionary {
        var timezoneDict: TimezoneDictionary = [:]
        
        for timezoneIdentifier in TimeZone.knownTimeZoneIdentifiers {
            if let timezone = TimeZone(identifier: timezoneIdentifier) {
                if let cityOptional = timezoneIdentifier.split(separator: "/").last {
                    var city = String(cityOptional)
                    let key: String = String(city.prefix(1))
                    
                    city = city.replacingOccurrences(of: "_", with: " ")
                    
                    if timezoneDict[key]?.append((city, timezone)) == nil {
                        timezoneDict[key] = [(city, timezone)]
                    }
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
    subscript(indexPath: IndexPath) -> Any {
        get {
            dataSource[indexPath.section].timezones[indexPath.row].0
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
        return dataSource[section].timezones.count
    }
    
    func didSelectBarButtonItem() {
        coordinator.start()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: dataSource[indexPath.section].timezones[indexPath.row])
    }
    
    func filterDataSource(text: String?) {
        if (text?.isEmpty ?? true) {
            isFilteringDataSource = false
            dataSource = allData
        } else {
            isFilteringDataSource = true
            var filteredData: [TimezoneSection] = []
            
            for row in allData {
                let filteredRow = row.timezones.filter { (title, zone) in
                    return title.lowercased().contains(text!.lowercased())
                }
                
                if !filteredRow.isEmpty {
                    filteredData.append(TimezoneSection(sectionTitle: row.sectionTitle,
                                                        timezones: filteredRow))
                }
            }
            
            dataSource = filteredData
        }
    }
}
