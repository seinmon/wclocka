/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at https://mozilla.org/MPL/2.0/. */

import Foundation

class WorldClockPresenter {
    let coordinator: Coordinator
    private var dataSource: [ClockModel] = []

    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
}

extension WorldClockPresenter: Presenter {
    subscript(indexPath: IndexPath) -> Any {
        get {
            return dataSource[indexPath.row]
        }
    }
    
    func getSectionCount() -> Int {
        1
    }
    
    func getRowCount(inSection section: Int) -> Int {
        dataSource.count
    }
    
    func didSelectBarButtonItem() {
        coordinator.start()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        coordinator.start(with: self[indexPath])
    }
}

extension WorldClockPresenter: CoordinatorDelegate {
    func didReceiveNewData(_ data: Any) {
        if let receivedData = data as? (String, TimeZone) {
            let clockItem = ClockModel(title: receivedData.0,
                                       timezone: receivedData.1)
            
            dataSource.append(clockItem)
        }
    }
}
