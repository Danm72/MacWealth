//
//  Position.swift
//
//  Created by Dan Malone
//
//

import Foundation
import ObjectMapper

struct Position: Mappable {
    
    private(set) var id: AccountID = ""
    private(set) var accountNo: String = ""
    private(set) var costBasis: Int = 0
    private(set) var initQty: Int = 0
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["accountID"]
        accountNo <- map["accountNo"]
        costBasis <- map["costBasis"]
        initQty <- map["initQty"]
    }
}


