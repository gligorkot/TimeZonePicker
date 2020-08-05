# TimeZonePicker

[![Build Status](https://app.bitrise.io/app/a8aacfeca49db0dd/status.svg?token=SyGPKzROHbYxep4c9-9czA)](https://app.bitrise.io/app/a8aacfeca49db0dd)
[![codebeat badge](https://codebeat.co/badges/dac53a60-fe1f-4b5f-9098-99b17d720977)](https://codebeat.co/projects/github-com-gligorkot-timezonepicker-master)
[![Version](https://img.shields.io/cocoapods/v/TimeZonePicker.svg)](http://cocoadocs.org/docsets/TimeZonePicker)
[![License](https://img.shields.io/cocoapods/l/TimeZonePicker.svg)](http://cocoadocs.org/docsets/TimeZonePicker)
[![Platform](https://img.shields.io/cocoapods/p/TimeZonePicker.svg)](http://cocoadocs.org/docsets/TimeZonePicker)

<a href='https://ko-fi.com/gligor' target='_blank'><img height='36' style='border:0px;height:36px;' src='https://az743702.vo.msecnd.net/cdn/kofi1.png?v=0' border='0' alt='Buy Me a Coffee at ko-fi.com' /></a>

A TimeZonePicker UIViewController and SwiftUI View similar to the iOS Settings app. Search and select from a range of cities and countries to find your most suitable time zone.

## Screenshots

![](Screenshots/Screenshot.png)
![](Screenshots/Preview.gif)

## Installation

### CocoaPods

To install it in your iOS project, install with [CocoaPods](http://cocoapods.org)

```ruby
pod 'TimeZonePicker'
```

## Usage

### Basic Initialisation

To initialise a `timeZonePicker` you can use the class function `getVC(withDelegate: TimeZonePickerDelegate)` on the `TimeZonePickerViewController` as below:

```swift
let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
```

Then you can use the `timeZonePicker` as you would any `UIViewController`, for example:

```swift
present(timeZonePicker, animated: true, completion: nil)
```

### TimeZonePickerDelegate

The `TimeZonePickerDelegate` currently has only one method that needs to be implemented:

```swift
func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone)
```

Once an item is selected from the table of cities/countries the above delegate method gets called, conveniently returning the `TimeZonePickerViewController` and the selected `TimeZone`. You can use the `timeZonePicker` to dismiss it here and the `timeZone` as you need it in your application. For example:

```swift
func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: TimeZone) {
    timeZoneName.text = timeZone.identifier
    timeZoneOffset.text = timeZone.abbreviation()
    timeZonePicker.dismiss(animated: true, completion: nil)
}
```

Please check the `TimeZonePickerExample` project for the above usage example. If you have any questions do not hesitate to get in touch with me.

### SwiftUI
In addition to the UIKit-based view controllers, there is also a SwiftUI View available, called `TimeZonePreviewSelectionView`.

![Preview view](Screenshots/SwiftUI_macOS_preview.png)
![Select view](Screenshots/SwiftUI_macOS_picker.png)

To use TimeZonePicker in a SwiftUI app, include `TimeZonePreviewSelectionView()` in your `View`, and bind it to a `CityCountryTimeZone` variable, like so:
```swift
struct ContentView: View {
    // variable storing the time zone data
    @State var myTimeZone: CityCountryTimeZone = CityCountryTimeZone()
    
    var body: some View {
        VStack {
            // Creates the time zone preview picker
            TimeZonePreviewSelectionView(cityItem: self.$myTimeZone)
            
            // Displays the selected time zone
            Text("The selected time zone is \(self.myTimeZone.timeZoneName)")
        }
    }
}
```
**Note:** So far, this has only been tested on macOS Catalina. It *should* work on iOS as well, but it is not guaranteed yet.

## Requirements

* iOS 8 or later.
* Swift 3

## License
    Copyright (c) 2017 Gligor Kotushevski

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
