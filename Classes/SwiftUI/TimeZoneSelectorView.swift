//
//  TimeZoneSelectorView.swift
//  Clock
//
//  Created by Malcolm Anderson on 7/25/20.
//  Copyright © 2020 Malcolm Anderson. All rights reserved.
//

import SwiftUI

struct TimeZoneSelectorView: View {
    @State var searchContent = "" {
        didSet {
            print("WILL SET SEARCH CONTENT")
            updateResults()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            TextField("Search", text: $searchContent)
            List {
                Text("New York, USA")
                Text("London, UK(?)")
                Text("Tokyo, Japan")
            }
            HStack {
                Button(action: cancel) { Text("Cancel") }
                Button(action: confirm) { Text("Select") }
            }
        }
        .frame(minWidth: 200, minHeight: 200)
    }
    
    func updateResults() {
        print("new content=\(searchContent)")
    }
    
    func cancel() {
        self.presentationMode.wrappedValue.dismiss()
    }
    
    func confirm() {
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct TimeZoneSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TimeZoneSelectorView()
    }
}
