//
//  StationsViewController.swift
//  FinchStationApp
//
//  Created by Bell on 2022-06-08.
//

import UIKit

protocol StationsView: AnyObject{
    func onStationsRetrieval(stations: [Station])
}


class StationsViewController: UIViewController, UITableViewDelegate {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.red
        setupUI()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    // MARK: - Properties
    var presenter: StationsViewPresenter!
    var stations: [Station] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .darkGray
        label.text = "No stored items yet"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UI Setup
    func setupUI() {
        
        navigationItem.title = "Menu"
        let navigationBar = UINavigationBar()
        navigationBar.barTintColor = UIColor.blue
       view.addSubview(navigationBar)
        
        view.addSubview(tableView)
        
        let layoutViews:[String:Any] = ["tableView":tableView,"navigationBar":navigationBar]
        var constraints = [NSLayoutConstraint]()
        let HConstraint = "H:|-10-[tableView]-10-|"
        let VConstraint = "V:|-[navigationBar]-10-[tableView]|"
        constraints += NSLayoutConstraint.constraints(withVisualFormat: HConstraint, options: .alignAllCenterY, metrics: nil, views: layoutViews)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: VConstraint, options: .alignAllLeading, metrics: nil, views: layoutViews)
        
        NSLayoutConstraint.activate(constraints)
        
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    }

}

// MARK: - View Protocol
extension StationsViewController: StationsView {
    
    func onStationsRetrieval(stations: [Station]) {
        print("View recieves the result from the Presenter.")
        self.stations = stations
        self.tableView.reloadData()
    }
    

}

// MARK: - UITableView Data Source
extension StationsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        tableView.isHidden = self.stations.isEmpty
//        placeholderLabel.isHidden = !self.stations.isEmpty
        placeholderLabel.isHidden = false
        
        return self.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = stations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // a place for a presenter method
        }
    }
    
    
}


