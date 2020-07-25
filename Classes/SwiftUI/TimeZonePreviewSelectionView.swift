//
//  TimeZonePreviewSelectionView.swift
//  Clock
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import SwiftUI

struct TimeZonePreviewSelectionView: View {
    @State var b = ""
    @State var selectorEnabled = false
    var body: some View {
        HStack {
            Text("New York, USA")
            Button(action: {self.selectorEnabled = true}) {
                Text("Select...")
            }
        }.sheet(isPresented: $selectorEnabled) {
            TimeZoneSelectorView()
        }
        
    }
}

struct TimeZonePreviewSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        TimeZonePreviewSelectionView()
    }
}
