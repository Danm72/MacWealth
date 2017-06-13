//
//  StatusMenuController.swift
//  MacWealth
//
//  Created by Dan Malone on 11/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
    
    @IBOutlet weak var statusHolder: NSView!
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var plLabel: NSTextField!
    @IBOutlet weak var dayImage: NSImageView!
    @IBOutlet weak var overallImg: NSImageView!
    @IBOutlet weak var dayText: NSTextField!
    @IBOutlet weak var overallText: NSTextField!
    var popover = NSPopover()

    var statusBarItem : NSStatusItem = NSStatusItem();
    var session: Session!
    var timer: Timer!
    var models: [EquityPosition]?
    var profitLoss = ProfitLoss(dailyPL: 0, overallPL: 0, equityValue: 0)
    
    public struct ProfitLoss {
        var dailyPL: Double = 0.0
        var overallPL: Double = 0.0
        var equityValue: Double = 0.0
    }
    
    override func awakeFromNib() {
        // Insert code here to initialize your application
        print("ran")
        statusItem.title = "MacWealth"
        statusItem.menu = statusMenu
        statusItem.view = statusHolder
        statusItem.toolTip = "MacWealth"
        
        let gesture = NSClickGestureRecognizer(target: self, action:  #selector (self.openPopover(sender:)))
        gesture.numberOfClicksRequired = 1
        statusHolder.addGestureRecognizer(gesture)

        setupSession()
        setupEvents()
    }
    
    func setupEvents(){
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseUp, handler: closePopover)
    }
    
    func openPopover(sender:NSClickGestureRecognizer){
        print("Opening Popover")
        
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let popoverController = storyboard.instantiateController(withIdentifier: "PopoverViewController") as! PopoverViewController
        
        if(self.models != nil){
            popoverController.models = self.models
            popoverController.profitLoss = self.profitLoss
        }
        
        if !popover.isShown {
            popover.contentViewController = popoverController
            popover.show(relativeTo: self.statusHolder.frame, of: self.statusHolder, preferredEdge: NSRectEdge.minY)
        } else {
            popover.close()
        }

    }
    
    func startTimer() {
        self.stop()
        self.getAccount()
        
        timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(15),
            target: self,
            selector: #selector(StatusMenuController.getAccount),
            userInfo: nil, repeats: true
        )
    }
    
    func stop() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    func setupSession(){
        let sessionRequest = SessionsServices.CreateSessionRequest(username: "USER", password: "PASS")
        
        SessionsServices.createSession(request: sessionRequest, success: { s in
            self.session = s
            self.getUser(session: s)
        }, failure: { (error) in
            print(error.localizedDescription)
        })
        
    }
    
    func getUser(session: Session){
        UsersServices.getUser(session: session, userID: session.userID, success: {
            success in
            self.startTimer()
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func getAccount(){
        AccountsServices.getLiveAccount(session: session, userID: session.userID, success: {
            account in
            //self.getAccountPerformance(account: account)
            self.getAccountSummary(account: account)
        }, failure: { (error) in
            print(error.localizedDescription)
            self.stop()
            self.setupSession()
        })
    }
    
    func getAccountPerformance(account: Account){
        AccountsServices.getAccountPerformance(session: self.session, userID: session.userID, accountID: account.id, success: {
            performance in
//            print(performance)
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func getAccountSummary(account: Account){
        AccountsServices.getAccountSummary(session: self.session, userID: session.userID, accountID: account.id, success: {
            summary in
            self.models = summary.positions
            
            self.updateUI(summary: summary)
        }, failure: { (error) in
            print(error.localizedDescription)
        })
    }
    
    func updateUI(summary: AccountSummary){
        
        for (index, position) in (summary.positions?.enumerated())! {
            print("Item \(index): \(position)")
            profitLoss.dailyPL += position.unrealizedDayPL
            profitLoss.overallPL += position.unrealizedPL
        }
        
        profitLoss.equityValue = summary.equityValue
        
        self.dayText.stringValue = "\(profitLoss.dailyPL)"
        self.overallText.stringValue = "\(profitLoss.overallPL)"
        if(profitLoss.dailyPL < 0){
            self.dayImage.image = #imageLiteral(resourceName: "down")
        }else {
            self.dayImage.image = #imageLiteral(resourceName: "up")
        }
        
        if(profitLoss.overallPL < 0){
            self.overallImg.image = #imageLiteral(resourceName: "down")
        }else {
            self.overallImg.image = #imageLiteral(resourceName: "up")
        }

        print("\n\n DailyPL: \(profitLoss.dailyPL) : OverallPL: \(profitLoss.overallPL)")
    }
    
    @IBAction func quitClicked(_ sender: Any) {
        NSApplication.shared().terminate(self)
    }
    
    func closePopover(aEvent: (NSEvent!)) -> Void {
        if popover.isShown {
            popover.close()
        }
    }
}
