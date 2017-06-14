//
//  EquityPosition.swift
//  MacWealth
//
//  Created by Dan Malone on 12/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Foundation
import ObjectMapper

struct EquityPosition: Mappable {
    private(set) var unrealizedPL: Double = 0
    private(set) var unrealizedDayPLPercent: Double = 0
    private(set) var unrealizedDayPL: Double = 0
    private(set) var symbol: String = ""
    private(set) var costBasis: Double = 0.0
    private(set) var mktPrice: Double = 0.0

    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        unrealizedPL <- map["unrealizedPL"]
        unrealizedDayPLPercent <- map["unrealizedDayPLPercent"]
        unrealizedDayPL <- map["unrealizedDayPL"]
        symbol <- map["symbol"]
        costBasis <- map["costBasis"]
        mktPrice <- map["mktPrice"]
    }
}
