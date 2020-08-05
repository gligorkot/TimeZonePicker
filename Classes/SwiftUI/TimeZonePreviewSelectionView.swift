//
//  TimeZonePreviewSelectionView.swift
//  TimeZonePicker
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import SwiftUI

struct TimeZonePreviewSelectionView: View {
    @Binding var cityItem: CityCountryTimeZone?
    @State var selectorEnabled = false
    var body: some View {
        HStack {
            Text(cityItem != nil ? cityItem!.string() : "None")
            Spacer()
            Button(action: {self.selectorEnabled = true}) {
                Text("Select...")
            }
        }.sheet(isPresented: $selectorEnabled) {
            TimeZoneSelectorView(searchContent: (self.cityItem != nil ? self.cityItem!.string() : ""), selectedTimeZone: self.$cityItem)
        }
        
    }
}
