//
//  CityCountryTimeZone.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Edited by Malcolm Anderson on 7/25/20.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import Foundation

struct CityCountryTimeZone: Codable, Hashable, Identifiable {
    var city = ""
    var country = ""
    var timeZoneName = ""
    
    public var id: String { return city + country }
    
    init() {
        self.city = "NULL"
        self.country = "NULL"
        self.timeZoneName = "NULL"
    }
    
    init(city: String, country: String, timeZoneName: String) {
        self.city = city
        self.country = country
        self.timeZoneName = timeZoneName
    }
    
    func contains(_ string: String) -> Bool {
        return self.string().lowercased().contains(string.lowercased())
    }
    
    func string() -> String {
        if country.isEmpty {
            return city
        }
        return "\(city), \(country)"
    }
    
}

extension CityCountryTimeZone: Equatable, Comparable {
    
    static func ==(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city == rhs.city && lhs.country == rhs.country && lhs.timeZoneName == rhs.timeZoneName
    }
    
    static func <(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city < rhs.city
    }
    
    static func <=(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city <= rhs.city
    }
    
    static func >=(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city >= rhs.city
    }
    
    static func >(lhs: CityCountryTimeZone, rhs: CityCountryTimeZone) -> Bool {
        return lhs.city > rhs.city
    }
    
}
