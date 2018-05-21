//
//  Treatment.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import Foundation

class Treatment{
    
    var treatmentDate: String
    var treatmentStage: String
    var doseLog: Bool
    var comment: String
    var products:[Product]
    
    init(){
        self.treatmentDate = ""
        self.treatmentStage = ""
        self.doseLog = false
        self.comment = ""
        self.products = [Product]()
    }
    
    init(treatmentDate: String, treatmentStage: String, doseLog: Bool, comment: String, products: [Product]){
        
        self.treatmentDate = treatmentDate
        self.treatmentStage = treatmentStage
        self.doseLog = doseLog
        self.comment = comment
        self.products = products
    }
}
