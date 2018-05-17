//
//  BlockSubBlocksViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 16.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class BlockSubBlocksViewController: UIViewController {
    var subBlocks = [[String:Any]]()
    var selectedBlock = [String:Any]()
    var subBlock = UIView()
    
    @IBOutlet weak var blockCharTop: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blockCharTop.text = "Block " + (selectedBlock["BlockChar"] as! String)
        
        let fieldRect:CGRect = CGRect.init(x: 43, y: 161, width: 469, height: 289)
        subBlock = UIView(frame: fieldRect)
        subBlock.layer.borderColor = UIColor.init(red:0.58, green:0.60, blue:0.60, alpha:1.0).cgColor
        subBlock.layer.borderWidth = 1
        self.view.addSubview(subBlock)
        
        var cellWidth = (subBlock.bounds.width as! NSNumber).intValue
        var cellHeight = (subBlock.bounds.height as! NSNumber).intValue
        
        for sBlock in subBlocks {
            let subBlockChar = "A"
            let posX = (sBlock["PosW"] as! Int) * cellWidth  / (selectedBlock["FieldBlockWidth"] as! Int) + 5
            let posY = (sBlock["PosL"] as! Int) * cellHeight / (selectedBlock["FieldBlockLength"] as! Int) + 5
            let subBlockWidth = (sBlock["SubBlockWidth"] as! Int) * cellWidth / (selectedBlock["FieldBlockWidth"] as! Int) - 10
            let subBlockLength = (sBlock["SubBlockLength"] as! Int) * cellHeight / (selectedBlock["FieldBlockLength"] as! Int) - 10
            
            let fieldRect:CGRect = CGRect.init(x: posX, y: posY, width: subBlockWidth, height: subBlockLength)
            let subBlockCell = UIView(frame: fieldRect)
            subBlockCell.backgroundColor = UIColor.init(red: 0.945, green: 1, blue: 0.953, alpha: 1)
            subBlockCell.layer.borderColor = UIColor.init(red:0.58, green:0.60, blue:0.60, alpha:1.0).cgColor
            subBlockCell.layer.borderWidth = 1
            
            let char = UILabel.init(frame: CGRect(x: subBlockCell.bounds.width/2, y: subBlockCell.bounds.height/2, width: 38, height: 32))
            char.text = subBlockChar
            char.textColor = UIColor.init(red:0.612, green:0.718, blue:0.631, alpha:1.0)
            char.font = UIFont.init(name: "Verdana", size: 32.0)
            char.transform = CGAffineTransform(rotationAngle: 0.5 * CGFloat.pi)
            char.center = CGPoint.init(x: subBlockCell.bounds.width/2, y: subBlockCell.bounds.height/2  + 8)
            subBlockCell.addSubview(char)
            subBlock.addSubview(subBlockCell)
        }
        
        subBlock.transform = CGAffineTransform(rotationAngle: 1.5*CGFloat.pi)
        subBlock.center = CGPoint.init(x: 187.5, y: 395.5 )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
