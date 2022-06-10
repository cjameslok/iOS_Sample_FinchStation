//
//  Station.swift
//  FinchStationApp
//
//  Created by Bell on 2022-06-08.
//

import UIKit

struct Station: Decodable {
    var name: String?
    var uri: String?
    var time: Int?
    var stops: [Station]?
    
//    enum CodingKeys: String, CodingKey {
//        case name = "name"
//        case uri = "uri"
//        case time = "time"
//        case stops = "stops"
//    }
    


}
