//
//  SubBlockTapHandler.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 17.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class SubBlockTapHandler: UIView, UIGestureRecognizerDelegate  {
    var subBlock = [String:Any]()
    var blockSubBlockCtrl = BlockSubBlocksViewController()
    
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        blockSubBlockCtrl.changeView(sBlock: subBlock)
    }
}
