//
//  TimeZoneDataManager.swift
//  TimeZonePicker
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import Foundation

class TimeZoneDataManager {
    static let sharedInstance = TimeZoneDataManager()
    
    var timeZones: [CityCountryTimeZone] = []
    
    private init() {
        self.loadTimeZoneData()
    }
    
    func loadTimeZoneData() {
        // copied from TimeZonePickerDataSource.swift
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                if let file = Bundle(for: TimeZoneDataManager.self).url(forResource: "CitiesAndTimeZones", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    do {
                        var timeZones = try JSONDecoder().decode([CityCountryTimeZone].self, from: data)
                        timeZones.sort()
                        DispatchQueue.main.async {
                            self.timeZones = timeZones
                            print("TimeZoneDataManager - setup is complete")
                        }
                    } catch {
                        // should never get here / invalid json
                        print("TimeZoneDataManager - invalid JSON")
                    }
                } else {
                    // should never get here / file does not exist
                    print("TimeZoneDataManager - JSON file doesn't exist")
                }
            } catch {
                // should never get here / unless Data or JSONSerialization throw an error
                print("TimeZoneDataManager - Data or JSONSerialization threw error")
            }
        }
    }
    
    func filter(_ str: String) -> [CityCountryTimeZone] {
        return self.timeZones.filter { timeZone -> Bool in
            timeZone.contains(str)
        }
    }
}
