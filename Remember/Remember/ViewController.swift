//
//  ViewController.swift
//  Remember
//
//  Created by Kevin_Feng on 2017/4/14.
//  Copyright © 2017年 Kevin_Feng. All rights reserved.
//

import Cocoa
import NotificationCenter
class ViewController: NSViewController, NSUserNotificationCenterDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBOutlet weak var startBtn: NSButton!
    @IBAction func startRem(_ sender: Any) {
        let notif = NSUserNotification()
        notif.title = "flamboyant"
        notif.informativeText = "炫的"
        notif.hasActionButton = true
        notif.actionButtonTitle = "重背"
        notif.soundName = NSUserNotificationDefaultSoundName
//        notif.isPresented = true
        let notifCenter = NSUserNotificationCenter.default
        
        notifCenter.delegate = self
        notifCenter.scheduleNotification(notif)
        
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
}

