//
//  BlockInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 16.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class BlockInfoViewController: UIViewController {
    var selectedBlock = [String:Any]()
    
    @IBOutlet weak var blockCharLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func ViewSubBlocks(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockCharLabel.text = "Block " +  (selectedBlock["BlockChar"] as! String)
        lengthLabel.text = (selectedBlock["FieldBlockLength"] as! NSNumber).stringValue + " m"
        widthLabel.text = (selectedBlock["FieldBlockWidth"] as! NSNumber).stringValue + " m"
        areaLabel.text = (((selectedBlock["FieldBlockLength"] as! NSNumber).intValue * (selectedBlock["FieldBlockWidth"] as! NSNumber).intValue) as! NSNumber).stringValue + " m2"
        commentLabel.text = selectedBlock["Comment"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

}
