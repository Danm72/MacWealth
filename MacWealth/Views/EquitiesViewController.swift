//
//  EquitiesViewController.swift
//  MacWealth
//
//  Created by Dan Malone on 12/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class EquitiesViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    
    var models : [EquityPosition]!
    
    @IBOutlet weak var fallbackView: NSTextField!
    @IBOutlet weak var buildsTable: NSTableView!
    @IBOutlet weak var dayImageView: NSImageView!
    @IBOutlet weak var overallPLImage: NSImageView!
    @IBOutlet weak var overallPLLabel: NSTextField!
    @IBOutlet weak var dayLabel: NSTextField!
    @IBOutlet weak var totalLabel: NSTextField!
    
    var profitLoss : StatusMenuController.ProfitLoss!

    override func viewDidLoad() {
        super.viewDidLoad()
        buildsTable.dataSource = self
        buildsTable.delegate = self
    }
    
    override func viewWillAppear() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(EquitiesViewController.reloadBuilds),
            name: NSNotification.Name(rawValue: "UpdatedEquities"),
            object: nil
        )
    }
    
    override func viewDidAppear() {
        self.reloadBuilds()
    }
    
    override func viewWillDisappear() {
    }
    
    func reloadBuilds() {
        setupFallBackViews()
        buildsTable.reloadData()
        reloadHeader()
    }
    
    func reloadHeader(){
        if(profitLoss != nil) {
            totalLabel.stringValue = "\(profitLoss.equityValue)"
            dayLabel.stringValue = "\(profitLoss.dailyPL)"
            overallPLLabel.stringValue = "\(profitLoss.overallPL)"
            
            if(profitLoss.dailyPL < 0){
                self.dayImageView.image = #imageLiteral(resourceName: "down")
            }else {
                self.dayImageView.image = #imageLiteral(resourceName: "up")
            }
            
            if(profitLoss.overallPL < 0){
                self.overallPLImage.image = #imageLiteral(resourceName: "down")
            }else {
                self.overallPLImage.image = #imageLiteral(resourceName: "up")
            }
        }
    }
    
    private func setupFallBackViews() {
        fallbackView.isHidden = false
        buildsTable.isHidden = true

        if (models == nil) {
            return fallbackView.stringValue = "Loading Recent Equities"
        }
        if (models.count == 0) {
            return fallbackView.stringValue = "No Recent Equities Found"
        }else {
            fallbackView.isHidden = true
            buildsTable.isHidden = false
        }
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        if models != nil {
            return models.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellView: BuildView = tableView.make(withIdentifier: tableColumn!.identifier, owner: self) as! BuildView
        cellView.setupForBuild(position: models[row])
        return cellView;
    }
    
    func selectionShouldChangeInTableView(tableView: NSTableView) -> Bool {
        return false
    }
}
