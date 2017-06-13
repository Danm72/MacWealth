//
//  AccountSummary.swift
//  MacWealth
//
//  Created by Dan Malone on 12/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Foundation
import ObjectMapper

struct AccountSummary: Mappable {
    private(set) var positions: [EquityPosition]?
    private(set) var equityValue: Double = 0.0
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        positions <- map["equity.equityPositions"]
        equityValue <- map["equity.equityValue"]
    }
}
