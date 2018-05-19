//
//  AddBlockInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddBlockInfoViewController: UIViewController {
    
    var addedBlock = FieldBlock()
    
    @IBOutlet weak var blockChar: UITextField!
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var comment: UITextField!
    
    @IBAction func characterChanged(_ sender: Any) {
        addedBlock.char = blockChar.text!
    }
    
    
    @IBAction func lengthChanged(_ sender: Any) {
        guard let lengthInt = Int(length.text!) else { return }
        guard let widthInt = Int(width.text!) else { return }
        area.text = ((widthInt * lengthInt) as! NSNumber).stringValue
        addedBlock.length = lengthInt
        addedBlock.width = widthInt
    
    }
    @IBAction func widthChanged(_ sender: Any) {
        guard let lengthInt = Int(length.text!) else { return }
        guard let widthInt = Int(width.text!) else { return }
        area.text = ((widthInt * lengthInt) as! NSNumber).stringValue
        addedBlock.length = lengthInt
        addedBlock.width = widthInt
    }
    
    @IBAction func commentChanged(_ sender: Any) {
        addedBlock.comment = comment.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
