//
//  AddTrialGroupViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddTrialGroupViewController: UIPageViewController, UIPageViewControllerDataSource {

    var passedTrialGrObj = TrialGroup()
    
    lazy var viewControllerList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewInfo = storyBoard.instantiateViewController(withIdentifier: "AddTrialGroupInfo")
        let viewSubBlocks = storyBoard.instantiateViewController(withIdentifier: "AddTreatment")
        
        return [viewInfo, viewSubBlocks]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         self.dataSource = self
        
        if let secondViewController = viewControllerList.last as? AddTreatmentViewController{
            secondViewController.addedTrialGroup = self.passedTrialGrObj
        }
        
        if let firstViewController = viewControllerList.first as? AddTrialGroupInfoViewController{
            firstViewController.addedTrialGroup = self.passedTrialGrObj
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

}
