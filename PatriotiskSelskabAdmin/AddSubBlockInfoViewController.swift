//
//  AddSubBlockInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddSubBlockInfoViewController: UIViewController {
    
    var addedSubBlock = SubBlock()
    
    @IBOutlet weak var charInput: UITextField!
    @IBOutlet weak var lengthLbl: UILabel!
    @IBOutlet weak var widthLbl: UILabel!
    @IBOutlet weak var areaLbl: UILabel!
    @IBOutlet weak var commentInput: UITextField!
    
    @IBAction func charChanged(_ sender: Any) {
        addedSubBlock.char = charInput.text!
    }
    @IBAction func commentChanged(_ sender: Any) {
        addedSubBlock.comment = commentInput.text!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lengthInt = addedSubBlock.length
        let widthInt = addedSubBlock.width
        lengthLbl.text = (lengthInt as NSNumber).stringValue + " m"
        widthLbl.text = (widthInt as NSNumber).stringValue + " m"
        areaLbl.text = ((widthInt * lengthInt) as NSNumber).stringValue + " m2"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
