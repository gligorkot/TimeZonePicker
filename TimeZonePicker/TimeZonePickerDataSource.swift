//
//  TimeZonePickerDataSource.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import UIKit

final class TimeZonePickerDataSource: NSObject {
    
    private let tableView: UITableView
    fileprivate let timeZones: [String] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update(onComplete: () -> ()) {
        onComplete()
    }
    
}

extension TimeZonePickerDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
