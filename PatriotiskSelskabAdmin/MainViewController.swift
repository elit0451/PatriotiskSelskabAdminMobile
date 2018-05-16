//
//  ViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 11.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit
import DropDown

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var selectedYear:String = ""
    var selectedBlock:Int = 0
    var selectedSubBlock:Int = 0
    var selectedTrialGroup:Int = 0
    var years:[String] = []
    var blocks:[[String: Any]] = []
    var subBlocks:[[String: Any]] = []
    var trialGroups:[[String: Any]] = []
    let yearDropDown = DropDown()
    let blockDropDown = DropDown()
    let subBlockDropDown = DropDown()
    let trialGroupDropDown = DropDown()
    
    @IBOutlet weak var selectYear: UIButton!
    @IBOutlet weak var selectBlock: UIButton!
    @IBOutlet weak var selectSubBlock: UIButton!
    @IBOutlet weak var selectTrialGroup: UIButton!
    @IBOutlet weak var yearCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearCollection.delegate = self
        yearCollection.dataSource = self
        
        yearDropDown.anchorView = selectYear
        blockDropDown.anchorView = selectBlock
        subBlockDropDown.anchorView = selectSubBlock
        trialGroupDropDown.anchorView = selectTrialGroup
        
        yearDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.selectedYear = item
            self.blocks = []
            let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else { return }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [[String: Any]] {
                    for object in array {
                        if((object["FieldBlockYear"] as! NSNumber).stringValue == self.selectedYear)
                        {
                            self.blocks.append(object)
                        }
                    }
                }
            }
            self.getData(url:"http://localhost:8000/data/FieldBlocks.json", myCompletionHandler: myCompHand)
        }
        
        blockDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            for block in self.blocks
            {
                if(block["BlockChar"] as! String == item)
                {
                    self.selectedBlock = (block["FieldBlockID"] as! NSNumber).intValue
                }
            }
            self.subBlocks = []
            let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else { return }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [[String: Any]] {
                    for object in array {
                        if((object["FieldBlockID"] as! NSNumber).intValue == self.selectedBlock)
                        {
                            self.subBlocks.append(object)
                        }
                    }
                }
            }
            self.getData(url:"http://localhost:8000/data/SubBlocks.json", myCompletionHandler: myCompHand)
        }
        
        subBlockDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            for subBlock in self.subBlocks
            {
                if(subBlock["SubBlockChar"] as! String == item)
                {
                    self.selectedSubBlock = (subBlock["SubBlockID"] as! NSNumber).intValue
                }
            }
            self.trialGroups = []
            
            let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else { return }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [[String: Any]] {
                    for object in array {
                        if((object["SubBlockID"] as! NSNumber).intValue == self.selectedSubBlock)
                        {
                            self.trialGroups.append(object)
                        }
                    }
                }
            }
            
            self.getData(url:"http://localhost:8000/data/TrialGroups.json", myCompletionHandler: myCompHand)
        }
        
        trialGroupDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            for trialGroup in self.trialGroups
            {
                if(item == (trialGroup["TrialGroupNr"] as! NSNumber).stringValue)
                {
                    self.selectedTrialGroup = (trialGroup["TrialGroupID"] as! NSNumber).intValue
                }
            }
        }
        
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [[String: Any]] {
                for object in array {
                    if(self.years.contains((object["FieldBlockYear"] as! NSNumber).stringValue) == false)
                    {
                        self.years.append((object["FieldBlockYear"] as! NSNumber).stringValue)
                    }
                }
                //Sort the years array in ascending order
                //self.years = self.years.sorted(by: { $0 > $1 })
                self.years.sort(by: { $0 > $1 })
            }
        }
        getData(url:"http://localhost:8000/data/FieldBlocks.json", myCompletionHandler: myCompHand)
        
    }
    @IBAction func selectYearClick(_ sender: Any) {
        
        yearDropDown.dataSource = years
        yearDropDown.show()
        
    }
    
    @IBAction func selectBlockClick(_ sender: Any) {
        blockDropDown.dataSource = []
        for block in blocks
        {
            blockDropDown.dataSource.append(block["BlockChar"] as! String)
        }
        blockDropDown.show()
    }
    
    
    @IBAction func selectSubBlockClick(_ sender: Any) {
        subBlockDropDown.dataSource = []
        for subBlock in subBlocks
        {
            subBlockDropDown.dataSource.append(subBlock["SubBlockChar"] as! String)
        }
        subBlockDropDown.show()
    }
    
    @IBAction func selectTrialGroupClick(_ sender: Any) {
        trialGroupDropDown.dataSource = []
        for trialGroup in trialGroups
        {
            trialGroupDropDown.dataSource.append((trialGroup["TrialGroupNr"] as! NSNumber).stringValue)
        }
        trialGroupDropDown.show()
    }
    
    @IBAction func SearchClick(_ sender: Any) {
        
        //TODO: Implement changing to the correct view
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = yearCollection.dequeueReusableCell(withReuseIdentifier: "yearCell", for: indexPath) as! yearCollectionViewCell
        
        cell.yearLbl.text = years[indexPath.row] as! String
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCellYear = years[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "YearView") as! YearViewController
        vc.selectedYear = selectedCellYear
        
        self.present(vc, animated: true, completion: nil)
    }

}
