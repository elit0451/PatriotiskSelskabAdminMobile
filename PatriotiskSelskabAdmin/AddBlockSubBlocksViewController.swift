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
    @IBOutlet weak var newBlockRect: UIView!
    
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
        
        refreshSubBlockRects()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let lengthInt = Int(lengthLbl.text!) else { return }
        guard let widthInt = Int(widthLbl.text!) else { return }
        subBlock = SubBlock()
        subBlock.length = lengthInt
        subBlock.width = widthInt
        subBlock.posL = Int(subBlockRect.frame.origin.x) * addedBlock.length / Int(blockRect.frame.width)
        subBlock.posW = Int(subBlockRect.frame.origin.y) * addedBlock.width / Int(blockRect.frame.height)
        
        super.viewDidAppear(animated)
        blockCharTop.text = "Block " + String(addedBlock.char).uppercased()
        
        refreshSubBlockRects()
        
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
        
        subBlock.posL = Int(subBlockRect.frame.origin.x) * addedBlock.length / Int(blockRect.frame.width)
        subBlock.posW = Int(subBlockRect.frame.origin.y) * addedBlock.width / Int(blockRect.frame.height)
    }
    
    func refreshSubBlockRects()
    {
        for subView in blockRect.subviews
        {
            if(subView.accessibilityIdentifier == "subBlockSubView" && subView.isHidden == false)
            {
                subView.removeFromSuperview()
            }
        }
        for subBlock in addedBlock.subBlocks
        {
            let subBlockViewCopy = newBlockRect.copyView()
            subBlockViewCopy.isHidden = false
            
            subBlockViewCopy.frame.origin.x = CGFloat(subBlock.posL * Int(blockRect.frame.width) / addedBlock.length)
            subBlockViewCopy.frame.origin.y = CGFloat(subBlock.posW * Int(blockRect.frame.height) / addedBlock.width)
            subBlockViewCopy.frame.size.width = CGFloat(subBlock.length * Int(blockRect.frame.width) / addedBlock.length)
            subBlockViewCopy.frame.size.height = CGFloat(subBlock.width * Int(blockRect.frame.height) / addedBlock.width)
            
            let char = UILabel.init(frame: CGRect(x: subBlockViewCopy.bounds.width/2, y: subBlockViewCopy.bounds.height/2, width: 38, height: 32))
            char.text = subBlock.char
            char.textColor = UIColor.init(red:0.612, green:0.718, blue:0.631, alpha:1.0)
            char.font = UIFont.init(name: "Verdana", size: 32.0)
            char.center = CGPoint.init(x: subBlockViewCopy.bounds.width/2 + 8, y: subBlockViewCopy.bounds.height/2)
            subBlockViewCopy.addSubview(char)
            subBlockViewCopy.accessibilityIdentifier = "subBlockSubView"
            
            blockRect.addSubview(subBlockViewCopy)
            
            
            let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.subBlockClicked (_:)))
            subBlockViewCopy.addGestureRecognizer(gesture)
            
            blockRect.sendSubview(toBack: subBlockViewCopy)
        }
    }
    
    @objc func subBlockClicked(_ sender:UITapGestureRecognizer){
        var newPassSubBlock = SubBlock()
        for subBlock in addedBlock.subBlocks
        {
            if(subBlock.char == (sender.view?.subviews[0] as! UILabel).text)
            {
                newPassSubBlock = subBlock
            }
        }
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "AddSubBlockView") as! AddSubBlockViewController
        vc.passedSubBlockObj = newPassSubBlock
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "AddSubBlockSegue")
        {
            guard let addSubBlockView = segue.destination as? AddSubBlockViewController else { return }
            addSubBlockView.passedSubBlockObj = subBlock
        }
    }
    
}
