//
//  SessionsServices.swift
//
//  Created by Dan Malone
//
//

import Foundation
import Alamofire
import ObjectMapper

class SessionsServices {

    struct CreateSessionRequest {
        let username: String
        let password: String
    }

    /**
     Create new session
     */
    class func createSession(request: CreateSessionRequest, success: @escaping (Session) -> Void, failure: @escaping (Error) -> Void) {
        let scale = UIScreen.main.scale
        let screenBounds = UIScreen.main.bounds

        let parameters: [String: Any] = [
            "username": request.username,
            "password": request.password,
            "appTypeID": "26",
            "appVersion": "0.1",
            "languageID": "en_US",
            "osType": "iOS",
            "osVersion": UIDevice.current.systemVersion,
            "scrRes": "\(screenBounds.width * scale)x\(screenBounds.height * scale)",
            "ipAddress": APIClient.getWiFiAddress() ?? "1.1.1.1"
        ]

        APIClient.requestJSON("/userSessions", method: HTTPMethod.post, parameters: parameters, headers: nil).then { data in
            
            if let session = Mapper<Session>().map(JSONObject: data) {
                success(session)
            } else {
                failure(APIClientError.Serialization)
            }
        }.failure(failure)
    }

    /**
     Checks validity and detailed information on a user's current session
     */
    class func getSession(session: Session, success: @escaping (Session) -> Void, failure: @escaping (Error) -> Void) {
        let headers: [String: String] = [
            "x-mysolomeo-session-key": session.token
        ]

        APIClient.requestJSON("/userSessions/\(session.token)", method: HTTPMethod.get, headers: headers).then { data in
            if let session = Mapper<Session>().map(JSONObject: data) {
                success(session)
            } else {
                failure(APIClientError.Serialization)
            }
        }.failure(failure)
    }

    /**
     Destroy (aka logout) a user session.
     */
    class func cancelSession(session: Session, success: (Void) -> Void, failure: (Error) -> Void) {

    }
}
