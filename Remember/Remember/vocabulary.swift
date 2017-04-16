//
//  vocabulary.swift
//  Remember
//
//  Created by Kevin_Feng on 2017/4/15.
//  Copyright © 2017年 Kevin_Feng. All rights reserved.
//

import Cocoa

class vocabulary: NSObject {
    var word:String!
    var defination:String!
    var remTimes:Int
    var wordId:Int
    init(_word:String , _defination:String, _wordId:Int){
//        super.init()
        self.word = _word
        self.defination = _defination
        remTimes = 0
        wordId = _wordId
    }
    func addRemTimes(){
        remTimes += 1;
    }
    func isDfcRem()->Bool{
        return remTimes>3 ? true : false;
    }
}
