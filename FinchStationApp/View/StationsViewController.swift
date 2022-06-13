//
//  StationsViewController.swift
//  FinchStationApp
//
//  Created by Bell on 2022-06-08.
//

import UIKit

protocol StationsView: AnyObject{
    func onStationsRetrieval(stations: [Station])
    func onShowStationStops(station: Station)
}


class StationsViewController: UITableViewController {
    
    // MARK: - Properties
    var presenter: StationsViewPresenter!
    var stations: [Station] = []
    var selectedIndex: IndexPath?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        let presenter = StationsPresenter(view: self)
        self.presenter = presenter
        self.setupNavBar()
        view.backgroundColor = UIColor(red: 1.00, green: 0.98, blue: 0.88, alpha: 1.00)
        self.tableView.register(StationDetailsDropCell.self, forCellReuseIdentifier: "stationCell")
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    //MARK: Table View code
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stations.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let selectedIndex = selectedIndex else {
            return 60
        }
        
        if selectedIndex == indexPath {return 120}
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex!], with: .none)
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! StationDetailsDropCell
        cell.viewController = self
        cell.station = stations[indexPath.row]
        cell.animate()
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        presentViewController(food: foods[indexPath.row])
//    }

    
    
    // MARK: - UI Setup
    
    func setupNavBar() {
        navigationItem.title = "Stations"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 0.38, green: 0.42, blue: 0.22, alpha: 1.00)
        appearance.titleTextAttributes = [.foregroundColor: UIColor(red: 1.00, green: 0.98, blue: 0.88, alpha: 1.00)]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(red: 1.00, green: 0.98, blue: 0.88, alpha: 1.00)]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

}

// MARK: - View Protocol
extension StationsViewController: StationsView {
    
    func onStationsRetrieval(stations: [Station]) {
        print("View recieves the result from the Presenter.")
        self.stations = stations
        
        //Testing
        var station1 = Station(name: "Station 1")
        var station2 = Station(name: "Station 2")
        var station3 = Station(name: "Station 3")
        station1.stops = [station2, station3]
        station2.stops = [station1, station3]
        station3.stops = [station1, station2]
        self.stations.append(station1)
        self.stations.append(station2)
        self.stations.append(station3)

        
        self.tableView.reloadData()
    }
    
    func onShowStationStops(station: Station) {
        self.navigationController?.pushViewController(StopsViewController(station: station), animated: true)
    }

}


