//
//  StationsViewPresenter.swift
//  FinchStationApp
//
//  Created by Bell on 2022-06-08.
//

import Alamofire
import Foundation

protocol StationsViewPresenter {
    init(view: StationsView)
    func viewDidLoad()
}

class StationsPresenter: StationsViewPresenter {
    
    weak var view: StationsView?
    private var stations: Result<Station>?
    
    
    required init(view: StationsView) {
        self.view = view
    }
    
    // MARK: - Protocol methods
    func viewDidLoad() {
        print("View notifies the Presenter that it has loaded.")
        retrieveItems()
    }
    
    // MARK: - Private methods
    private func retrieveItems() {
        print("Presenter retrieves station from API")
    
        let request = Alamofire.request("https://myttc.ca/finch_station.json")
        
        

        request.responseJSON { (response) in
            print(response)
            do {
                if(response.result.isSuccess){
                    let result = try JSONDecoder().decode(Station.self, from: response.data!)
                    let stations: [Station] = [result]
                    self.view?.onStationsRetrieval(stations: stations)
                }
            } catch {
                print(error)
            }

        }

        
//        let stations: [Station]? = self.stations?
//            .map { $0 }
//        view?.onStationsRetrieval(stations: stations ?? [])
//        view?.onStationsRetrieval(stations: [])
    }
    
}
