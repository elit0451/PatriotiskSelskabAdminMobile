//
//  AddBlockSubBlocksViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddBlockSubBlocksViewController: UIViewController {
    
    var addedBlock = FieldBlock()
    var subBlock = SubBlock()
    
    @IBOutlet weak var blockCharTop: UILabel!
    @IBOutlet weak var lengthLbl: UITextField!
    @IBOutlet weak var widthLbl: UITextField!
    @IBOutlet weak var subBlockRect: UIView!
    @IBOutlet weak var blockRect: UIView!
    
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    
    @IBAction func lengthChanged(_ sender: Any) {
        guard let lengthInt = Int(lengthLbl.text!) else { return }
        guard let widthInt = Int(widthLbl.text!) else { return }
        subBlockRect.frame.size.width = CGFloat((lengthInt * Int(blockRect.frame.width) / addedBlock.length))
        subBlockRect.frame.size.height = CGFloat((widthInt * Int(blockRect.frame.height) / addedBlock.width))
        
        (subBlockRect.subviews[0] as! UIButton).center = CGPoint.init(x: subBlockRect.frame.size.width / 2, y: subBlockRect.frame.height / 2)
        
        subBlock.length = lengthInt
        subBlock.width = widthInt
        
    }
    @IBAction func widthChanged(_ sender: Any) {
        guard let lengthInt = Int(lengthLbl.text!) else { return }
        guard let widthInt = Int(widthLbl.text!) else { return }
        subBlockRect.frame.size.width = CGFloat((lengthInt * Int(blockRect.frame.width) / addedBlock.length))
        subBlockRect.frame.size.height = CGFloat((widthInt * Int(blockRect.frame.height) / addedBlock.width))
        
        (subBlockRect.subviews[0] as! UIButton).center = CGPoint.init(x: subBlockRect.frame.size.width / 2, y: subBlockRect.frame.height / 2)
        
        subBlock.length = lengthInt
        subBlock.width = widthInt
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockRect.layer.borderWidth = 2.0
        blockRect.layer.borderColor = UIColor.init(red: 0.518, green: 0.855, blue: 0.937, alpha: 1).cgColor
        
        subBlockRect.layer.borderWidth = 1.0
        subBlockRect.layer.borderColor = UIColor.init(red: 0.584, green: 0.596, blue: 0.604, alpha: 1).cgColor
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blockCharTop.text = "Block " + String(addedBlock.char).uppercased()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func viewWasDragged(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: subBlockRect)
        
        var newCenter = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        
        let halfx = subBlockRect.bounds.midX
        newCenter.x = max(halfx, newCenter.x)
        newCenter.x = min(blockRect.bounds.size.width - halfx,
                          newCenter.x)
        
        let halfy = subBlockRect.bounds.midY
        newCenter.y = max(halfy, newCenter.y)
        newCenter.y = min(blockRect.bounds.size.height - halfy,
                          newCenter.y)
        
        sender.view!.center = newCenter
        
        sender.setTranslation(CGPoint.zero, in: blockRect)
        
        subBlock.posL = 0 //TODO
        subBlock.posW = 0 //Change!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addSubBlockView = segue.destination as? AddSubBlockViewController else { return }
        
        addSubBlockView.passedSubBlockObj = subBlock
    }

}
