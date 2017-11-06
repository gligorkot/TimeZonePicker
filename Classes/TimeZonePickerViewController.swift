//
//  TimeZonePickerViewController.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import UIKit

public final class TimeZonePickerViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    public class func getVC(withDelegate delegate: TimeZonePickerDelegate) -> UINavigationController {
        let storyboard = UIStoryboard(name: "TimeZonePicker", bundle: Bundle(for: TimeZonePickerViewController.self))
        let nc = storyboard.instantiateInitialViewController() as! UINavigationController
        if let vc = nc.topViewController as? TimeZonePickerViewController {
            vc.delegate = delegate
        }
        return nc
    }
    
    private lazy var dataSource: TimeZonePickerDataSource = {
        let ds = TimeZonePickerDataSource(tableView: self.tableView)
        ds.delegate = self
        return ds
    }()
    
    weak var delegate: TimeZonePickerDelegate?

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureSearchBar()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
        DispatchQueue.main.async {
            self.searchBar.becomeFirstResponder()
        }
    }
    
    private func update() {
        dataSource.update { _ in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension TimeZonePickerViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.filter(searchText)
        tableView.reloadData()
    }
    
}

extension TimeZonePickerViewController: TimeZonePickerDataSourceDelegate {
    
    func timeZonePickerDataSource(_ timeZonePickerDataSource: TimeZonePickerDataSource, didSelectTimeZone timeZone: TimeZone) {
        delegate?.timeZonePicker(self, didSelectTimeZone: timeZone)
    }
    
}
