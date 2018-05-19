//
//  SubBlockTrialGroupsViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 17.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class SubBlockTrialGroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var trialGroupsCollection: UICollectionView!
    @IBOutlet weak var subBlockTop: UILabel!
    
    
    var selectedSubBlock = [String:Any]()
    var trialGroups = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        trialGroupsCollection.delegate = self
        trialGroupsCollection.dataSource = self
        self.subBlockTop.text = "Sub-block " +  (self.selectedSubBlock["SubBlockChar"] as! String)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.trialGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trialGroupsCollection.dequeueReusableCell(withReuseIdentifier: "trialGroupCell", for: indexPath) as! TrialGroupCollectionViewCell
        
        cell.trialGroupNr.text = (trialGroups[indexPath.row]["TrialGroupNr"] as! NSNumber).stringValue
        cell.weedType.text = trialGroups[indexPath.row]["CropName"] as! String
        cell.chemicalName.text = trialGroups[indexPath.row]["LogChemName"] as! String
        
        var logDosages = ""
        for logChemDosage in trialGroups[indexPath.row]["LogChemDosages"] as! [Decimal]{
            
        logDosages += (logChemDosage as NSNumber).stringValue + " | "
        }
        if(logDosages != ""){
        logDosages.removeLast(2)
        cell.dosages.text = logDosages + " ml"
        }
        else{
            cell.dosages.text = ""
        }
            cell.layer.borderWidth = 2.0
            cell.layer.borderColor = UIColor.init(red: 0.416, green: 0.745, blue: 0.953, alpha: 1).cgColor
        
        return cell
    }
    
    func getData(url: String, myCompletionHandler: Any?){
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: myCompletionHandler as! (Data?, URLResponse?, Error?) -> Void).resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCellTrialGr = trialGroups[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "TrialGroupView") as! TrialGroupViewController
        vc.selectedTrialGroup = selectedCellTrialGr
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
}
