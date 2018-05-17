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
            let subBlockChar = sBlock["SubBlockChar"] as! String
            let posX = (sBlock["PosW"] as! Int) * cellWidth  / (selectedBlock["FieldBlockWidth"] as! Int) + 5
            let posY = (sBlock["PosL"] as! Int) * cellHeight / (selectedBlock["FieldBlockLength"] as! Int) + 5
            let subBlockWidth = (sBlock["SubBlockWidth"] as! Int) * cellWidth / (selectedBlock["FieldBlockWidth"] as! Int) - 10
            let subBlockLength = (sBlock["SubBlockLength"] as! Int) * cellHeight / (selectedBlock["FieldBlockLength"] as! Int) - 10
            
            let fieldRect:CGRect = CGRect.init(x: posX, y: posY, width: subBlockWidth, height: subBlockLength)
            let subBlockCell = SubBlockTapHandler(frame: fieldRect)
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
            
            let tap = UITapGestureRecognizer(target: subBlockCell, action: #selector(subBlockCell.handleTap(sender:)))
            tap.delegate = subBlockCell
            subBlockCell.addGestureRecognizer(tap)
            
            subBlockCell.subBlock = sBlock
            subBlockCell.blockSubBlockCtrl = self
            
            subBlock.addSubview(subBlockCell)
        }
        
        subBlock.transform = CGAffineTransform(rotationAngle: 1.5*CGFloat.pi)
        subBlock.center = CGPoint.init(x: 187.5, y: 395.5 )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeView(sBlock:[String:Any]){
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "SubBlockView") as! SubBlockViewController
        vc.selectedSubBlock = sBlock
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
