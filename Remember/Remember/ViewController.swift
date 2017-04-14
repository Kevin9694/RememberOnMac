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
    
    
    @IBOutlet weak var vocabularyInputTF: NSTextField!
    
    
    var vocabularySet = [vocabulary]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    var rptTimer:Timer!
    @IBOutlet weak var startBtn: NSButton!
    @IBOutlet weak var stopBtn: NSButton!
    @IBAction func startRem(_ sender: Any) {
        rptTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(deliverNotif), userInfo: nil, repeats: true)
        rptTimer.fire()
    }
    
    @IBAction func stopRem(_ sender: Any) {
        rptTimer.invalidate()
    }
    
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    func deliverNotif(){
        if(0 != vocabularySet.count){
            let notif = NSUserNotification()
            notif.title = vocabularySet.first?.word
            notif.informativeText = vocabularySet.first?.defination
            notif.hasActionButton = true
            notif.actionButtonTitle = "重背"
            notif.otherButtonTitle = "记住了"
            notif.soundName = NSUserNotificationDefaultSoundName
            //        notif.deliveryRepeatInterval = DateComponents
            //        notif.isPresented = true
            let notifCenter = NSUserNotificationCenter.default
            notifCenter.delegate = self
            //        notifCenter.scheduleNotification(notif)
            notifCenter.deliver(notif)
            vocabularySet.remove(at: 0)
        }
        else{
            let notif = NSUserNotification()
            notif.title = "背完了!"
            notif.informativeText = "干的漂亮"
            notif.soundName = NSUserNotificationDefaultSoundName
            //        notif.deliveryRepeatInterval = DateComponents
            //        notif.isPresented = true
            let notifCenter = NSUserNotificationCenter.default
            notifCenter.delegate = self
            //        notifCenter.scheduleNotification(notif)
            notifCenter.deliver(notif)
            rptTimer.invalidate()
        }
    }
    @IBAction func addVocabulaySet(_ sender: Any) {
        let initString = vocabularyInputTF.stringValue
        let vocabularyArr = initString.components(separatedBy: "#1")
        var vcblUnitArr:[String]
        for vocabularyUnit in vocabularyArr{
            vcblUnitArr = vocabularyUnit.components(separatedBy: "#0")
            if("" != vocabularyUnit){
                vocabularySet.append(vocabulary(_word: vcblUnitArr[0],_defination: vcblUnitArr[1]))
            }
            
//            print("word:\(vcblUnitArr[0]),def:\(vcblUnitArr[1])")
        }
    }

//    func addVocabulary(){
//        
//        vocabularySet.append()
//    }
}

