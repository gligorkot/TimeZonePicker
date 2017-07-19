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
    private var timeZones: [String] = []
    fileprivate var filteredTimeZones: [String] = []
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func update(onComplete: @escaping (_ successful: Bool) -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let file = Bundle.main.url(forResource: "CitiesAndTimeZones", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let rootArray = json as? [[String : String]] {
                        // json is an array of [String : String] dictionaries
                        for element in rootArray {
                            let city: String = element["name"]!
                            let country: String = element["country"]!
                            if !country.isEmpty {
                                self.timeZones.append("\(city), \(country)")
                            } else {
                                self.timeZones.append("\(city)")
                            }
                        }
                        self.timeZones.sort()
                        self.filter("")
                        onComplete(true)
                    } else {
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
        self.filteredTimeZones = timeZones.filter({ return $0.contains(searchString) })
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
            cell.textLabel?.text = filteredTimeZones[indexPath.item]
            return cell
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = filteredTimeZones[indexPath.item]
        return cell
    }
    
}
