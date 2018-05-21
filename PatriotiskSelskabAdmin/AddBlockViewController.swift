//
//  AddBlockViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddBlockViewController: UIPageViewController, UIPageViewControllerDataSource {
    var passedBlockObj = FieldBlock()
    
    lazy var viewControllerList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewInfo = storyBoard.instantiateViewController(withIdentifier: "AddBlockInfo")
        let viewSubBlocks = storyBoard.instantiateViewController(withIdentifier: "AddBlockSubBlocks")
        
        return [viewInfo, viewSubBlocks]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self

        if let secondViewController = viewControllerList.last as? AddBlockSubBlocksViewController{
            secondViewController.addedBlock = self.passedBlockObj
        }
        
        if let firstViewController = viewControllerList.first as? AddBlockInfoViewController{
            firstViewController.addedBlock = self.passedBlockObj
            self.setViewControllers([firstViewController], direction: .forward, animated:
                true, completion: nil)
        }
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {return nil}
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        let nextIndex = vcIndex + 1
        guard viewControllerList.count != nextIndex else {return nil}
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didUnwindToAddBlockView(_ sender: UIStoryboardSegue){
        
        let found = passedBlockObj.subBlocks.contains
        {
            $0.char == (sender.source as! AddSubBlockInfoViewController).addedSubBlock.char
        }
        if(!found)
        {
            if((sender.source as! AddSubBlockInfoViewController).addedSubBlock.char != "")
            {
                passedBlockObj.subBlocks.append((sender.source as! AddSubBlockInfoViewController).addedSubBlock)
            }
        }
    }

}
