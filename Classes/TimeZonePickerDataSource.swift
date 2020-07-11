//
//  TimeZonePickerDataSource.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import UIKit

protocol TimeZonePickerDataSourceDelegate: class {
    func timeZonePickerDataSource(_ timeZonePickerDataSource: TimeZonePickerDataSource, didSelectTimeZone timeZone: TimeZone)
}

final class TimeZonePickerDataSource: NSObject {
    
    private let tableView: UITableView
    private var timeZones: [CityCountryTimeZone] = []
    
    private var searchText = ""
    private var filteredTimeZones: [CityCountryTimeZone] {
        if searchText.isEmpty {
            return timeZones
        } else {
            return timeZones.filter({ return $0.contains(searchText) })
        }
    }
    
    weak var delegate: TimeZonePickerDataSourceDelegate?
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update(onComplete: @escaping (_ successful: Bool) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let file = Bundle(for: TimeZonePickerDataSource.self).url(forResource: "CitiesAndTimeZones", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    do {
                        var timeZones = try JSONDecoder().decode([CityCountryTimeZone].self, from: data)
                        timeZones.sort()
                        
                        DispatchQueue.main.async {
                            self.timeZones = timeZones
                            self.filter("")
                            onComplete(true)
                        }
                    } catch {
                        
                        // should never get here / invalid json
                        onComplete(false)
                    }
                } else {
                    // should never get here / file does not exist
                    onComplete(false)
                }
            } catch {
                // should never get here / unless Data or JSONSerialization throw an error
                onComplete(false)
            }
        }
    }
    
    func filter(_ searchString: String) {
        searchText = searchString
    }
    
}

extension TimeZonePickerDataSource: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTimeZones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = filteredTimeZones[indexPath.item].string()
            return cell
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredTimeZones[indexPath.item].string()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = filteredTimeZones[indexPath.item]
        if let selectedTimeZone = TimeZone(identifier: selectedItem.timeZoneName) {
            delegate?.timeZonePickerDataSource(self, didSelectTimeZone: selectedTimeZone)
        }
    }
    
}
