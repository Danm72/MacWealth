//
//  AccountsServices.swift
//
//  Created by Dan Malone
//
//

import Foundation

class AccountsServices {

    struct CreateLiveAccountRequest {

    }
    /**
     Create a new funded live account (aka "real trading"). Before sending listed params, the user must have a valid username and userID
     */
    class func createLiveAccount(session: Session, request: CreateLiveAccountRequest, userID: String, success: (_ username: String) -> Void, failure: (Error) -> Void) {

    }

    /**
     After a user creates a live account they must verify their identity for KYC and AML purposes by uploading their picture ID and/or proof of address. Accepting JPG, GIF, PNG and PDF.
     */
    class func addDocument(session: Session, image: UIImage, success: (Bool) -> Void, failure: (Error) -> Void) {

    }
}
