//
//  FieldBlock.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import Foundation

class FieldBlock{
    
    var char: String
    var year: String
    var length: Int
    var width: Int
    var comment: String
    var subBlocks:[SubBlock]
    
    init()
    {
        char = ""
        self.year = ""
        self.length = 0
        self.width = 0
        self.comment = ""
        self.subBlocks = [SubBlock]()
    }
    
    init(blockChar: String, year: String, length: Int, width: Int, comment: String){
        self.char = blockChar
        self.year = year
        self.length = length
        self.width = width
        self.comment = comment
        self.subBlocks = [SubBlock]()
    }
}
