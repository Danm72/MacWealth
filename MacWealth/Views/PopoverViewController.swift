//
//  PopoverViewController.swift
//  MacWealth
//
//  Created by Dan Malone on 12/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class PopoverViewController: NSViewController {
    
    var clickEventMonitor : AnyObject!
    @IBOutlet weak var subcontrollerView : NSView!
    @IBOutlet weak var openSettingsButton : NSButton!
//    @IBOutlet weak var openBuildsButton : NSButton!
    @IBOutlet weak var openUpdatesButton : NSButton!
    @IBOutlet weak var shutdownButton : NSButton!
    @IBOutlet weak var opacityFixView: NSImageView!
    
    var settingsViewController : SettingsViewController!
    var equitiesViewController : EquitiesViewController!
    var models : [EquityPosition]!
    var profitLoss : StatusMenuController.ProfitLoss!
    
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        setupNavButtons()
        setupStoryboardControllers()
        setupViewControllers()

//        showUpdateButtonIfAppropriate()
    }
    
    private func setupViewControllers() {
//
//        if isDarkModeEnabled() {
//            opacityFixView.image = NSImage(named: "opacity-fix-dark")
//        } else {
//            opacityFixView.image = NSImage(named: "opacity-fix-light")
//        }

        settingsViewController.parentView = self
        equitiesViewController.models = models
        equitiesViewController.profitLoss = profitLoss
//        updatesViewController.applicationStatus = self.applicationStatus
//        
//        openBuildsButton.hidden = true;
        subcontrollerView.addSubview(equitiesViewController.view)
    }
    
    public func updateEq(){
        equitiesViewController.models = models
        equitiesViewController.profitLoss = profitLoss
    }
    
    private func setupStoryboardControllers() {
//
        let storyboard = NSStoryboard(name: "Main", bundle: nil);
        settingsViewController = storyboard.instantiateController(withIdentifier: "SettingsViewController") as! SettingsViewController
        equitiesViewController = storyboard.instantiateController(withIdentifier: "EquitiesViewController") as! EquitiesViewController
//        updatesViewController = storyboard?.instantiateControllerWithIdentifier("UpdatesController") as! UpdatesController
    }
    
    private func setupNavButtons() {
        //Templated images cause background overlay weirdness
        if isDarkModeEnabled() {
            openSettingsButton.image = NSImage(named: "settings")
//            openBuildsButton.image = NSImage(named: "back")
            shutdownButton.image = NSImage(named: "power")
        } else {
            openSettingsButton.image = NSImage(named: "settings-alt")
//            openBuildsButton.image = NSImage(named: "back-alt")
            shutdownButton.image = NSImage(named: "power-alt")
        }
    }
    
    @IBAction func openSettings(sender: NSButton) {
        openSettingsButton.isHidden = true
        openUpdatesButton.isHidden = true
        shutdownButton.isHidden = true
//        openBuildsButton.isHidden = false
        equitiesViewController.view.removeFromSuperview()
        subcontrollerView.addSubview(settingsViewController.view)
    }
    
    @IBAction func openBuilds(sender: NSButton) {
//        showUpdateButtonIfAppropriate()
//        openBuildsButton.isHidden = true;
        shutdownButton.isHidden = false
        openSettingsButton.isHidden = false
        settingsViewController.view.removeFromSuperview()
//        updatesViewController.view.removeFromSuperview()
        subcontrollerView.addSubview(equitiesViewController.view)
    }
    
    @IBAction func openUpdates(sender: NSButton) {
        openUpdatesButton.isHidden = true
        openSettingsButton.isHidden = true
        shutdownButton.isHidden = true
//        openBuildsButton.isHidden = false
//        buildsViewController.view.removeFromSuperview()
//        subcontrollerView.addSubview(updatesViewController.view)
    }
    
    @IBAction func shutdownApplication(sender: NSButton) {
        NSApplication.shared().terminate(self);
    }
    
//    private func showUpdateButtonIfAppropriate() {
//        if applicationStatus.hasUpdate {
//            let versionString = NSMutableAttributedString(string: applicationStatus.latestVersion)
//            let range = NSMakeRange(0, count(applicationStatus.latestVersion))
//            versionString.addAttribute(
//                NSForegroundColorAttributeName,
//                value: NSColor.redColor(),
//                range: range
//            )
//            versionString.fixAttributesInRange(range)
//            openUpdatesButton.attributedTitle = versionString
//            openUpdatesButton.hidden = false
//            
//            if appDelegate.OS_IS_MAVERICKS_OR_LESS() {
//                updatesViewController.setup()
//            }
//            
//        } else {
//            openUpdatesButton.hidden = true
//        }
//    }
    
    private func isDarkModeEnabled() -> Bool {
        let dictionary  = UserDefaults.standard.persistentDomain(forName: UserDefaults.globalDomain);
        if let interfaceStyle = dictionary?["AppleInterfaceStyle"] as? NSString {
            return interfaceStyle.localizedCaseInsensitiveContains("dark")
        } else {
            return false
        }
    }
}
