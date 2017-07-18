//
//  TimeZonePickerViewController.swift
//  TimeZonePicker
//
//  Created by Gligor Kotushevski on 19/07/17.
//  Copyright © 2017 Gligor Kotushevski. All rights reserved.
//

import UIKit

final class TimeZonePickerViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var dataSource: TimeZonePickerDataSource = {
        let ds = TimeZonePickerDataSource(tableView: self.tableView)
        return ds
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    private func update() {
        dataSource.update {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private func configureTableView() {
        tableView.tableFooterView = UIView()
    }
    
}

