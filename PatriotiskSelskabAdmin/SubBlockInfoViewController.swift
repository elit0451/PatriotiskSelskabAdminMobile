//
//  SubBlockInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 17.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class SubBlockInfoViewController: UIViewController {
    var selectedSubBlock = [String:Any]()
    
    @IBOutlet weak var subBlockCharLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var widthLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func viewTrialGroups(_ sender: UIButton) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subBlockCharLabel.text = "Sub-block " +  (selectedSubBlock["SubBlockChar"] as! String)
        lengthLabel.text = (selectedSubBlock["SubBlockLength"] as! NSNumber).stringValue + " m"
        widthLabel.text = (selectedSubBlock["SubBlockWidth"] as! NSNumber).stringValue + " m"
        areaLabel.text = (((selectedSubBlock["SubBlockLength"] as! NSNumber).intValue * (selectedSubBlock["SubBlockWidth"] as! NSNumber).intValue) as! NSNumber).stringValue + " m2"
        commentLabel.text = selectedSubBlock["Comment"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
