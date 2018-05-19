//
//  SubBlockViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class SubBlockViewController: UIPageViewController, UIPageViewControllerDataSource {
    var selectedSubBlock = [String:Any]()
    var trialGroups = [[String:Any]]()
    
    lazy var viewControllerList:[UIViewController] = {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let viewInfo = storyBoard.instantiateViewController(withIdentifier: "SubBlockInfo")
        let viewTrialGroups = storyBoard.instantiateViewController(withIdentifier: "SubBlockTrialGroups")
        
        return [viewInfo, viewTrialGroups]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        getTrialGroups()
        
        if let firstViewController = viewControllerList.first as? SubBlockInfoViewController{
            firstViewController.selectedSubBlock = self.selectedSubBlock
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    
    func getData(url: String, myCompletionHandler: Any?){
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: myCompletionHandler as! (Data?, URLResponse?, Error?) -> Void).resume()
    }
    
    func getTrialGroups() {
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [[String: Any]] {
                for object in array {
                    if((object["SubBlockID"] as! NSNumber).intValue == (self.selectedSubBlock["SubBlockID"] as! NSNumber).intValue)
                    {
                        self.trialGroups.append(object)
                    }
                }
            }
            self.getTreatments()
        }
        self.getData(url:"http://localhost:8000/data/TrialGroups.json", myCompletionHandler: myCompHand)
    }
    
    func getTreatments() {
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [[String: Any]] {
                var newTrialGroups = [[String:Any]]()
                for var trGroup in self.trialGroups{
                    
                    var logChemName = ""
                    var logChemDosages = [Decimal]()
                    var treatments = [[String:Any]]()
                    for object in array {
                        if((object["TrialGroupID"] as! NSNumber).intValue == (trGroup["TrialGroupID"] as! NSNumber).intValue)
                        {
                            treatments.append(object)
                            if (object["DoseLog"] as! Bool == true) {
                                logChemName = object["ProductName"] as! String
                                logChemDosages.append((object["ProductDose"] as! NSNumber).decimalValue)
                            }
                        }
                    }
                   logChemDosages.sort(by: { $0 > $1 })
                    
                    trGroup["Treatments"] = treatments
                    trGroup["LogChemName"] = logChemName
                    trGroup["LogChemDosages"] = logChemDosages
                    newTrialGroups.append(trGroup)
                }
                
                self.trialGroups = newTrialGroups
                
                
                if let secondViewController = self.viewControllerList.last as? SubBlockTrialGroupsViewController{
                    secondViewController.trialGroups = self.trialGroups
                    secondViewController.selectedSubBlock = self.selectedSubBlock
                }
            }
        }
        self.getData(url:"http://localhost:8000/data/Treatment.json", myCompletionHandler: myCompHand)
    }
    
    @IBAction func didUnwindToSubBlockView(_ sender: UIStoryboardSegue){
    }
    
    
}
