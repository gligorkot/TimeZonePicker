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
    
    fileprivate lazy var dataSource: TimeZonePickerDataSource = {
        let ds = TimeZonePickerDataSource(tableView: self.tableView, delegate: self)
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
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
}

extension TimeZonePickerViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        dataSource.filter(searchText)
        tableView.reloadData()
    }
    
}

extension TimeZonePickerViewController: TimeZonePickerDataSourceDelegate {
    
    func timeZonePickerDataSource(_ timeZonePickerDataSource: TimeZonePickerDataSource, didSelectTimeZone timeZone: NSTimeZone) {
        delegate?.timeZonePicker(self, didSelectTimeZone: timeZone)
    }
    
}
