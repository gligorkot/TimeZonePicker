//
//  ViewController.swift
//  TimeZonePickerExample
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import UIKit
import TimeZonePicker

class ViewController: UIViewController {

    @IBOutlet weak var timeZoneName: UILabel!
    @IBOutlet weak var timeZoneOffset: UILabel!
    
    @IBAction func selectTimeZoneTapped(_ sender: UIButton) {
        let timeZonePicker = TimeZonePickerViewController.getVC(withDelegate: self)
        present(timeZonePicker, animated: true, completion: nil)
    }

}

extension ViewController: TimeZonePickerDelegate {
    
    func timeZonePicker(_ timeZonePicker: TimeZonePickerViewController, didSelectTimeZone timeZone: NSTimeZone) {
        timeZoneName.text = timeZone.name
        timeZoneOffset.text = timeZone.abbreviation
        timeZonePicker.dismiss(animated: true, completion: nil)
    }
    
}

