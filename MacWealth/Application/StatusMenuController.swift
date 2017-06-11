//
//  StatusMenuController.swift
//  MacWealth
//
//  Created by Dan Malone on 11/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var stockHorView: NSStackView!
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var plLabel: NSTextField!
    
    var statusBarItem : NSStatusItem = NSStatusItem();
    //    var statusBarIconViewController : SeaEyeIconController!;
    
    override func awakeFromNib() {
        // Insert code here to initialize your application
        print("ran")
        statusItem.title = "MacWealth"
        statusItem.menu = statusMenu
        statusItem.view = stockHorView
    }
    
    func makeReq(){
        let sessionRequest = SessionsServices.CreateSessionRequest(username: "username", password: "password")
        var session: Session!
        
        SessionsServices.createSession(request: sessionRequest, success: { s in
            session = s
            print(s.token)
            UsersServices.getUser(session: session, userID: s.userID, success: {
                success in
                AccountsServices.getLiveAccount(session: session, userID: session.userID, success: {
                    account in
                    print(account)
                    AccountsServices.getAccountPerformance(session: session, userID: session.userID, accountID: account.id, success: {
                        performance in
                        print(performance)
                    }, failure: { (error) in
                        print(error.localizedDescription)
                    })
                }, failure: { (error) in
                    print(error.localizedDescription)
                })
            }, failure: { (error) in
                print(error.localizedDescription)
            })
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }

    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
}
