//
//  Session.swift
//
//  Created by Dan Malone
//
//

import Foundation
import ObjectMapper

typealias SessionToken = String

struct Session: Mappable {
    private(set) var token: SessionToken = ""
    private(set) var userID: String = ""
    
    init?(map: Map) { }

    mutating func mapping(map: Map) {
        token <- map["sessionKey"]
        userID <- map["userID"]
    }
}
