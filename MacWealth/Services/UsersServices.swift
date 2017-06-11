//
//  UsersServices.swift
//
//  Created by Dan Malone
//
//

import Foundation
import Alamofire
import ObjectMapper

class UsersServices {

    struct CreateUserRequest {
        let username: String
        let password: String
        let firstName: String
        let lastName: String
        let email: String
    }

    /**
     Create new username
     */
    class func createUser(request: CreateUserRequest, success: @escaping (User) -> Void, failure: @escaping (Error) -> Void) {

        let parameters: [String: Any] = [
            "username": request.username,
            "password": request.password,
            "firstName": request.firstName,
            "lastName": request.lastName,
            "emailAddress1": request.email,
            "wlpID": "DW"
        ]

        APIClient.requestJSON("/signups/live", method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).then { data in
            if let user = Mapper<User>().map(JSONObject: data) {
                success(user)
            } else {
                failure(APIClientError.Serialization)
            }
        }.failure(failure)
    }

    /**
     Provides details on a specific user.
     */
    class func getUser(session: Session, userID: String, success: (User) -> Void, failure: @escaping (Error) -> Void) {
        
    }

}
