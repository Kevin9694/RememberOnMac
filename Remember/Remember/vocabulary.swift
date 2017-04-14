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

    init(_word:String , _defination:String){
        super.init()
        self.word = _word
        self.defination = _defination
    }
}
