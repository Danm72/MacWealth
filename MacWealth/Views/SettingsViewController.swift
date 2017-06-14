//
//  SettingsViewController.swift
//  MacWealth
//
//  Created by Dan Malone on 13/06/2017.
//  Copyright © 2017 Mawla. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {
    
    var parentView : PopoverViewController!
    
    @IBOutlet weak var runOnStartup : NSButton!
    @IBOutlet weak var showNotifications : NSButton!
    
    @IBOutlet weak var passwordField
    : NSTextField!
    @IBOutlet weak var usernameField : NSTextField!
    @IBOutlet weak var projectsField : NSTextField!
    @IBOutlet weak var usersField : NSTextField!
    @IBOutlet weak var branchesField : NSTextField!
    
    @IBOutlet weak var versionString : NSTextField!
    
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        setupInputFields()
    }
    
    @IBAction func saveUserData(sender: NSButton) {

        setUserDefaultsFromField(field: passwordField, key: "PasswordKey")
        setUserDefaultsFromField(field: usernameField, key: "UsernameKey")

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SettingsChanged"), object: nil)
        parentView.openBuilds(sender: sender)
    }

    private func setUserDefaultsFromField(field: NSTextField, key: String) {
        let userDefaults = UserDefaults.standard
        let fieldValue = field.stringValue
        if fieldValue.isEmpty {
            userDefaults.removeObject(forKey: key)
        } else {
            userDefaults.setValue(fieldValue, forKey: key)
        }
    }

    private func setupInputFields() {
        setupFieldFromUserDefaults(field: passwordField, key: "PasswordKey")
        setupFieldFromUserDefaults(field: usernameField, key: "UsernameKey")

    }

    private func setupFieldFromUserDefaults(field: NSTextField, key: String) {
        let userDefaults = UserDefaults.standard
        if let savedValue = userDefaults.string(forKey: key) {
            field.stringValue = savedValue
        }
    }

}
