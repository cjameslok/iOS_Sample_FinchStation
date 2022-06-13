//
//  StopsViewController.swift
//  FinchStationApp
//
//  Created by Bell on 2022-06-13.
//

import Foundation
import UIKit

class StopsViewController: UITableViewController {
    
    // MARK: - Properties
//    var presenter: StationsViewPresenter!
    var station: Station
//    var selectedIndex: IndexPath?
    
    
    init(station: Station) {
        self.station = station
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
//        let presenter = StationsPresenter(view: self)
//        self.presenter = presenter

        super.viewDidLoad()
        
        navigationItem.title = station.name
        view.backgroundColor = UIColor(red: 1.00, green: 0.98, blue: 0.88, alpha: 1.00)
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "stopCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 60
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    //MARK: Table View code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let stops = self.station.stops else {
            return 0
        }
        return stops.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 60
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        selectedIndex = indexPath
//        tableView.beginUpdates()
//        tableView.reloadRows(at: [selectedIndex!], with: .none)
//        tableView.endUpdates()
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stopCell", for: indexPath)
        cell.textLabel?.text = station.stops?[indexPath.row].name!
//        cell.tintColor = UIColor(red: 0.38, green: 0.42, blue: 0.22, alpha: 1.00)
        cell.backgroundColor = UIColor(red: 1.00, green: 0.98, blue: 0.88, alpha: 1.00)
        return cell
    }
    

}

