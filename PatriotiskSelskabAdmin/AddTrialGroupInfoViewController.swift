//
//  TrialGroupInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 17.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit
import DropDown

class AddTrialGroupInfoViewController: UIViewController {
    
    var addedTrialGroup = TrialGroup()
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    @IBOutlet weak var selectCrop: UIButton!
    
    let cropDropDown = DropDown()
    var crops:[String] = []
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var treatmentCommentView: UIView!
    @IBOutlet weak var productsView: UIView!
    @IBOutlet weak var stageView: UIView!
    
    @IBAction func numberChanged(_ sender: Any) {
        addedTrialGroup.trialGrNumber = Int(numberInput.text!)!
    }
    @IBAction func commentChanged(_ sender: Any) {
        addedTrialGroup.comment = commentInput.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cropDropDown.anchorView = selectCrop
        
        cropDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.addedTrialGroup.cropName = item
            self.crops = []
            let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                }
                guard let data = data else { return }
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let array = json as? [Any] {
                    for object in array {
                        self.crops.append(object as! String)
                    }
                }
            }
            self.getData(url:"http://localhost:8000/data/Weeds.json", myCompletionHandler: myCompHand)
            print(self.crops)
        }
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
    
    
}
