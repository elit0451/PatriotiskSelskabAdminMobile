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
    
    var selectedYear = ""
    var blocks = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()

        //blockCollection.delegate = self
        blockCollection.dataSource = self
        
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
                print(self.blocks, "\n")
                //self.blocks.sort { ($0["BlockChar"] as! String) < ($1["BlockChar"] as! String) }
                //print(self.blocks)
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
        cell.BlockChar.text = blocks[indexPath.row]["BlockChar"] as! String
        
        return cell
    }

}
