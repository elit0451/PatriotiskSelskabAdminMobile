//
//  AddSubBlockTrialGroupsViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddSubBlockTrialGroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var addedSubBlock = SubBlock()
    var trialGroupObj = TrialGroup()
    
    @IBOutlet weak var subBlCharTop: UILabel!
    @IBOutlet weak var trialGroupsCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trialGroupsCollection.delegate = self
        trialGroupsCollection.dataSource = self
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addedSubBlock.trialGroups.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = TrialGroupCollectionViewCell()
        
        if(indexPath.row == 0){
            cell = trialGroupsCollection.dequeueReusableCell(withReuseIdentifier: "addTrialGroupCell", for: indexPath) as! TrialGroupCollectionViewCell
        }
        else {
            cell = trialGroupsCollection.dequeueReusableCell(withReuseIdentifier: "trialGroupCell", for: indexPath) as! TrialGroupCollectionViewCell
            
            var logChemName:String = ""
            var logChemDosage:String = ""
            
            for treatment in addedSubBlock.trialGroups[indexPath.row - 1].treatments
            {
                var products = [Product]()
                
                for product in treatment.products
                {
                    var added = false
                    for newProduct in products
                    {
                        if(newProduct.name == product.name)
                        {
                            if(logChemName == "")
                            {
                                logChemName = product.name
                                logChemDosage += (newProduct.dose as NSNumber).stringValue + " ! " + (product.dose as NSNumber).stringValue + " ! "
                            }
                            else
                            {
                                logChemDosage += (product.dose as NSNumber).stringValue + " ! "
                            }
                            added = true
                        }
                    }
                    if(!added)
                    {
                        products.append(product)
                    }
                }
            }
            
            cell.trialGroupNr.text = (addedSubBlock.trialGroups[indexPath.row - 1].trialGrNumber as NSNumber).stringValue
            cell.weedType.text = addedSubBlock.trialGroups[indexPath.row - 1].cropName
            cell.dosages.text = logChemDosage
            cell.chemicalName.text = logChemName
            
        }
        
        cell.layer.borderWidth = 2.0
        cell.backgroundColor = UIColor.init(red: 0.945, green: 1, blue: 0.953, alpha: 1)
        cell.layer.borderColor = UIColor.init(red: 0.416, green: 0.745, blue: 0.953, alpha: 1).cgColor
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        trialGroupObj = TrialGroup()
        subBlCharTop.text = "Sub-block " + String(addedSubBlock.char).uppercased()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addNewTrialGroupSegue")
        {
            guard let addTrialGroupView = segue.destination as? AddTrialGroupViewController else { return }
            addTrialGroupView.passedTrialGrObj = trialGroupObj
        }
        else if(segue.identifier == "addTrialGroupSegue")
        {
            guard let addTrialGroupView = segue.destination as? AddTrialGroupViewController else { return }
            for trGr in addedSubBlock.trialGroups
            {
                if(trGr.trialGrNumber == Int((sender as! TrialGroupCollectionViewCell).trialGroupNr.text!))
                {
                    addTrialGroupView.passedTrialGrObj = trGr
                }
            }
        }
    }
    
    func refreshTrialGroupView()
    {
        trialGroupsCollection.reloadData()
    }
    
}
