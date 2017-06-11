//
//  AccountPerformance.swift
//  MacWealth
//
//  Created by Dan Malone on 10/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Foundation
import ObjectMapper


struct AccountPerformance: Mappable {
    
    private(set) var lastUpdated: String = ""
    private(set) var cash: Double = 0
    private(set) var performance: [Performance]?
    
    struct Performance: Mappable {
        var realizedDayPL: Double = 0
        var unrealizedDayPL: Double = 0
        var cumRealizedPL: Double = 0
        var equity: Double = 0
        var cash: Double = 0
        //        "date": "2016-07-19",
        //        "equity": 4553.95
        
        init?(map: Map) {}
        
        mutating func mapping(map: Map) {
            realizedDayPL <- map["realizedDayPL"]
            unrealizedDayPL <- map["unrealizedDayPL"]
            cumRealizedPL <- map["cumRealizedPL"]
            equity <- map["equity"]
            cash <- map["cash"]
        }
    }
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        lastUpdated <- map["lastUpdated"]
        performance <- map["performance"]
    }
}

