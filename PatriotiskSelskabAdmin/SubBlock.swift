//
//  SubBlock.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import Foundation

class SubBlock{
    
    var char: String
    var trialGroupsAmount: Int
    var lastTrialGrNr: Int
    var length: Int
    var width: Int
    var posL: Int
    var posW: Int
    var comment: String
    var trialGroups:[TrialGroup]
    
    init(){
        
        self.char = ""
        self.trialGroupsAmount = 0
        self.lastTrialGrNr = 0
        self.length = 0
        self.width = 0
        self.posL = 0
        self.posW = 0
        self.comment = ""
        self.trialGroups = [TrialGroup]()
    }
    
    init(char: String, trialGroupsAmount: Int, lastTrialGrNr: Int, length: Int, width: Int, posL: Int, posW: Int, comment: String){
        
        self.char = char
        self.trialGroupsAmount = trialGroupsAmount
        self.lastTrialGrNr = lastTrialGrNr
        self.length = length
        self.width = width
        self.posL = posL
        self.posW = posW
        self.comment = comment
        self.trialGroups = [TrialGroup]()
    }
}


