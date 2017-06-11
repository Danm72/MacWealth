//
//  Account.swift
//
//  Created by Dan Malone
//
//

import Foundation
import ObjectMapper

typealias AccountID = String

struct Account: Mappable {
    
    private(set) var id: AccountID = ""
    private(set) var nickname: String = ""
    private(set) var cash: Double = 0
    private(set) var positions: [Position]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["accountID"]
        cash <- map["cash"]
        positions <- map["positions"]
        nickname <- map["nickname"]
    }
}

