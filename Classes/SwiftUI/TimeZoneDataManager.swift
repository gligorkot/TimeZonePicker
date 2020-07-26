//
//  TimeZoneDataManager.swift
//  Clock
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import Foundation

class TimeZoneDataManager {
    static let sharedInstance = TimeZoneDataManager()
    
    var timeZones: [CityCountryTimeZone] = []
    
    private init() {
        print("Initialize TimeZoneDataManager...")
        self.loadTimeZoneData()
    }
    
    func loadTimeZoneData() {
        // copied from TimeZonePickerDataSource.swift
        print("Load time zone data on another thread")
        DispatchQueue.global(qos: .userInitiated).async {
            print("we're in the other thread")
            do {
                if let file = Bundle(for: TimeZoneDataManager.self).url(forResource: "CitiesAndTimeZones", withExtension: "json") {
                    let data = try Data(contentsOf: file)
                    print(file.absoluteString)
                    do {
                        var timeZones = try JSONDecoder().decode([CityCountryTimeZone].self, from: data)
                        timeZones.sort()
                        print("TIMEZONE - sorted!")
                        DispatchQueue.main.async {
                            self.timeZones = timeZones
                            print("TIMEZONE - list is set, we should be all good :)")
                        }
                    } catch {
                        // should never get here / invalid json
                        print("TIMEZONE ERROR - json was invalid")
                    }
                } else {
                    // should never get here / file does not exist
                    print("TIMEZONE ERROR - file doesn't exist")
                }
            } catch {
                // should never get here / unless Data or JSONSerialization throw an error
                print("TIMEZONE ERROR - Data, JSONSerialization threw error")
            }
        }
    }
    
    func filter(_ str: String) -> [CityCountryTimeZone] {
        return self.timeZones.filter { timeZone -> Bool in
            timeZone.contains(str)
        }
    }
}
