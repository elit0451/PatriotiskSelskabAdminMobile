//
//  BlockControllerViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class BlockViewController: UIPageViewController, UIPageViewControllerDataSource {
    var selectedBlock = [String:Any]()
    var subBlocks = [[String:Any]]()
    
    lazy var viewControllerList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewInfo = storyBoard.instantiateViewController(withIdentifier: "BlockInfo")
        let viewSubBlocks = storyBoard.instantiateViewController(withIdentifier: "BlockSubBlocks")
        
        return [viewInfo, viewSubBlocks]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        getSubBlocks()
        
        if let secondViewController = viewControllerList.last as? BlockSubBlocksViewController{
            secondViewController.subBlocks = self.subBlocks
            secondViewController.selectedBlock = self.selectedBlock
        }
        
        if let firstViewController = viewControllerList.first as? BlockInfoViewController{
            firstViewController.selectedBlock = self.selectedBlock
            self.setViewControllers([firstViewController], direction: .forward, animated:
                true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func getData(url: String, myCompletionHandler: Any?){
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: myCompletionHandler as! (Data?, URLResponse?, Error?) -> Void).resume()
    }
    
    func getSubBlocks() {
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [[String: Any]] {
                for object in array {
                    if((object["FieldBlockID"] as! NSNumber).intValue == (self.selectedBlock["FieldBlockID"] as! NSNumber).intValue)
                    {
                        self.subBlocks.append(object)
                    }
                }
            }
        }
        self.getData(url:"http://localhost:8000/data/SubBlocks.json", myCompletionHandler: myCompHand)
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
    
    @IBAction func didUnwindToBlockView(_ sender: UIStoryboardSegue){
    }
}
