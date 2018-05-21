//
//  AddYearViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddYearViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var selectedYear = ""
    var blockObj = FieldBlock()
    var fieldBlocks = [FieldBlock]()
    @IBOutlet weak var yearTop: UILabel!
    @IBOutlet weak var blockCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        blockCollection.delegate = self
        blockCollection.dataSource = self
        
        self.yearTop.text = self.selectedYear
        blockObj.year = selectedYear
        
        let plusObj = FieldBlock()
        plusObj.char = "+"
        fieldBlocks.append(plusObj)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fieldBlocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = blockCollection.dequeueReusableCell(withReuseIdentifier: "blockCell", for: indexPath) as! BlockCollectionViewCell
        
        cell.layer.borderWidth = 2.0
        cell.backgroundColor = UIColor.init(red: 0.945, green: 1, blue: 0.953, alpha: 1)
        cell.layer.borderColor = UIColor.init(red: 0.416, green: 0.745, blue: 0.953, alpha: 1).cgColor
        
        cell.BlockChar.text = fieldBlocks[indexPath.row].char
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addBlockSegue")
        {
            let index = blockCollection.indexPath(for: sender as! UICollectionViewCell)?.row
             guard let addBlockView = segue.destination as? AddBlockViewController else { return }
            
            if(index == 0){
                blockObj = FieldBlock()
                blockObj.year = selectedYear
                addBlockView.passedBlockObj = blockObj
            }
            else{
                addBlockView.passedBlockObj = fieldBlocks[index!]
            }
        }
    }
    
    @IBAction func didUnwindToAddYearView(_ sender: UIStoryboardSegue){
        
        let found = fieldBlocks.contains
        {
            $0.char == (sender.source as! AddBlockInfoViewController).addedBlock.char
        }
        if(!found)
        {
            fieldBlocks.append((sender.source as! AddBlockInfoViewController).addedBlock)
        }
        blockCollection.reloadData()
    }
    
}
