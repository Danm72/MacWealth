//
//  BuildView.swift
//  MacWealth
//
//  Created by Dan Malone on 12/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class BuildView: NSTableCellView {
    @IBOutlet var statusColorBox : NSBox!
    @IBOutlet var statusAndSubject : NSTextField!
    @IBOutlet var branchName : NSTextField!
    @IBOutlet var timeAndBuildNumber : NSTextField!
    @IBOutlet var openURLButton : NSButton!
    @IBOutlet weak var overallPL: NSTextField!
    @IBOutlet weak var totalValue: NSTextField!
    var url : NSURL!
    
    func setupForBuild(position: EquityPosition) {
        statusAndSubject.stringValue = "\(position.symbol)"
        branchName.stringValue = "$\(position.unrealizedDayPL)"
        overallPL.stringValue = "$\(position.unrealizedPL)"
        totalValue.stringValue = "$\(position.costBasis)"
    }
}
