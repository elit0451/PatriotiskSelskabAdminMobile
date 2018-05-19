//
//  TrialGroup.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import Foundation

class TrialGroup{
    
    var trialGrNumber: Int
    var cropName: String
    var comment: String
    var treatments:[Treatment]
    
    init()
    {
        self.trialGrNumber = 0
        self.cropName = ""
        self.comment = ""
        self.treatments = [Treatment]()
    }
    
    init(trialGrNumber: Int, cropName: String, comment: String){
        
        self.trialGrNumber = trialGrNumber
        self.cropName = cropName
        self.comment = comment
        self.treatments = [Treatment]()
    }
}
