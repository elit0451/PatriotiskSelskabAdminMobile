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
        subBlCharTop.text = "Sub-block " + String(addedSubBlock.char).uppercased()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let addTrialGroupView = segue.destination as? AddTrialGroupViewController else { return }
        addTrialGroupView.passedTrialGrObj = trialGroupObj
    }
    
}
