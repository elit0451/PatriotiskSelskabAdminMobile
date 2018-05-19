//
//  YearViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class YearViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var blockCollection: UICollectionView!
    @IBOutlet weak var yearTop: UILabel!
    @IBAction func backBtn(_ sender: UIButton) {
        
    }
    
    var selectedYear = ""
    var selectedBlock = [String:Any]()
    var blocks:[[String:Any]] = []
    var subBlocks = [[String: Any]]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockCollection.delegate = self
        blockCollection.dataSource = self
        self.yearTop.text = self.selectedYear
        
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
                
                self.blocks.sort { ($0["BlockChar"] as! String) < ($1["BlockChar"] as! String) }
                self.getSubBlocks()
            }
        }
        self.getData(url:"http://localhost:8000/data/FieldBlocks.json", myCompletionHandler: myCompHand)
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
        return blocks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = blockCollection.dequeueReusableCell(withReuseIdentifier: "blockCell", for: indexPath) as! BlockCollectionViewCell
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.init(red: 0.416, green: 0.745, blue: 0.953, alpha: 1).cgColor
        
        let cellWidth = (cell.bounds.width as NSNumber).intValue
        let cellHeight = (cell.bounds.height as NSNumber).intValue
        
        
        for sBlock in self.subBlocks{
            
            let posX = (sBlock["PosW"] as! Int) * cellWidth / (blocks[indexPath.row]["FieldBlockWidth"] as! Int) + 2
            let posY = (sBlock["PosL"] as! Int) * cellHeight / (blocks[indexPath.row]["FieldBlockLength"] as! Int) + 2
            let subBlockWidth = (sBlock["SubBlockWidth"] as! Int) * cellWidth / (blocks[indexPath.row]["FieldBlockWidth"] as! Int) - 4
            let subBlockLength = (sBlock["SubBlockLength"] as! Int) * cellHeight / (blocks[indexPath.row]["FieldBlockLength"] as! Int) - 4
            
            if(sBlock["FieldBlockID"] as! NSNumber == blocks[indexPath.row]["FieldBlockID"] as! NSNumber)
            {
                let rect:CGRect = CGRect.init(x: posX, y: posY, width: subBlockWidth, height: subBlockLength)
                let subBlock = UIView(frame: rect)
                subBlock.backgroundColor = UIColor.init(red: 0.945, green: 1, blue: 0.953, alpha: 1)
                subBlock.layer.borderColor = UIColor.init(red:0.58, green:0.60, blue:0.60, alpha:1.0).cgColor
                subBlock.layer.borderWidth = 1
                cell.addSubview(subBlock)
            }
        }
        cell.BlockChar.text = blocks[indexPath.row]["BlockChar"] as! String
        cell.addSubview(cell.BlockChar)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCellBlock = blocks[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil);
        let vc = sb.instantiateViewController(withIdentifier: "BlockView") as! BlockViewController
        vc.selectedBlock = selectedCellBlock
        
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func getSubBlocks() {
        self.subBlocks = []
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            for block in self.blocks {
                if let array = json as? [[String: Any]] {
                    for object in array {
                        if((object["FieldBlockID"] as! NSNumber).intValue == (block["FieldBlockID"] as! NSNumber).intValue)
                        {
                            self.subBlocks.append(object)
                        }
                    }
                }
            }
        }
        self.getData(url:"http://localhost:8000/data/SubBlocks.json", myCompletionHandler: myCompHand)
    }
    
    @IBAction func didUnwindToYearView(_ sender: UIStoryboardSegue){
    }
    
}
