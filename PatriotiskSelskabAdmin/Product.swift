//
//  Product.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import Foundation

class Product{
    
    var name: String
    var dose: Decimal
    var unit: String
    
    init(name: String, dose: Decimal, unit: String){
        
        self.name = name
        self.dose = dose
        self.unit = unit
    }
}
