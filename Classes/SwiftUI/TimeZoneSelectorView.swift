//
//  TimeZoneSelectorView.swift
//  TimeZonePicker
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import SwiftUI

struct TimeZoneSelectorView: View {
    @State var searchContent = ""
    @Binding var selectedTimeZone: CityCountryTimeZone?
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TextField("Search", text: self.$searchContent)
            List(self.getFilteredList(), id: \.self, selection: self.$selectedTimeZone) { item in
                Text(item.string()).tag(item)
                
            }
            HStack {
                Button(action: cancel) { Text("Cancel") }
                Button(action: confirm) { Text("Select") }
            }
        }
        .frame(minWidth: 200, minHeight: 200)
    }
    
    func getFilteredList() -> [CityCountryTimeZone] {
        return TimeZoneDataManager.sharedInstance.filter(self.searchContent)
    }
    
    func cancel() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func confirm() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
