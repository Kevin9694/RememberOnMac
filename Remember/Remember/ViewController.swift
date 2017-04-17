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
    
    
    var vocabularySetDisp = [vocabulary]()
    var vocabularySetRec = [vocabulary]()
    
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
        rptTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(deliverNotif), userInfo: nil, repeats: true)
        rptTimer.fire()
    }
    
    @IBAction func stopRem(_ sender: Any) {
        rptTimer.invalidate()
    }
    
    
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    
    func deliverNotif(){
        if(0 != vocabularySetDisp.count){
            let notif = NSUserNotification()
            notif.title = vocabularySetDisp.first?.word
            notif.informativeText = vocabularySetDisp.first?.defination
            notif.hasActionButton = true
            notif.actionButtonTitle = "重背"
            notif.otherButtonTitle = "记住了"
            notif.soundName = NSUserNotificationDefaultSoundName
//            notif.userInfo?["id"] = vocabularySetDisp.first?.wordId
            //        notif.deliveryRepeatInterval = DateComponents
            //        notif.isPresented = true
            let notifCenter = NSUserNotificationCenter.default
            notifCenter.delegate = self
            //        notifCenter.scheduleNotification(notif)
            
            notifCenter.deliver(notif)
            vocabularySetDisp.remove(at: 0)
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
        var counter = 0
        for vocabularyUnit in vocabularyArr{
            counter += 1
            vcblUnitArr = vocabularyUnit.components(separatedBy: "#0")
            if("" != vocabularyUnit){
                vocabularySetDisp.append(vocabulary(_word: vcblUnitArr[0],_defination: vcblUnitArr[1], _wordId: counter))
                vocabularySetRec.append(vocabulary(_word: vcblUnitArr[0], _defination: vcblUnitArr[1], _wordId: counter))
            }
            
//            print("word:\(vcblUnitArr[0]),def:\(vcblUnitArr[1])")
        }
    }
    

//    func addVocabulary(){
//
//        vocabularySet.append()
//    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        var id:Int!
        var title = notification.title
        if "背完了!" == title{
            
        }else{
            for vcblUnit in vocabularySetRec{
                if(vcblUnit.word == title){
                    id = vcblUnit.wordId
                }
            }
            //            id = notification.userInfo?["id"] as! Int
            //TODO: fix it!
            vocabularySetRec[id-1].addRemTimes()
            if 1 >= vocabularySetDisp.count{
                self.vocabularySetDisp.insert(vocabularySetRec[id-1], at: 0)
            }else{
                vocabularySetDisp.insert(self.vocabularySetRec[id-1], at: 1)

            }
            

        }
}
    @IBAction func export(_ sender: Any) {
        var str = exportDifRemVoc()
        let pasteboard = NSPasteboard.general()
        pasteboard.declareTypes([NSStringPboardType], owner: nil)
        pasteboard.setString(str, forType: NSStringPboardType)
    }
    func exportDifRemVoc()->String{
        var rtnStr = ""
        for vcblUnit in vocabularySetRec{
            if vcblUnit.isDfcRem(){
                rtnStr += vcblUnit.word + "#0" + vcblUnit.defination+"#1\n"
                print(vcblUnit.word+"\n"+vcblUnit.defination+"\n\n")
            }
        }
        return rtnStr
    }
}

