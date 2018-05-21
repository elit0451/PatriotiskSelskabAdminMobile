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
        guard let trialGrNr = Int(numberInput.text!) else { return }
        addedTrialGroup.trialGrNumber = trialGrNr
    }
    @IBAction func commentChanged(_ sender: Any) {
        addedTrialGroup.comment = commentInput.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(addedTrialGroup.trialGrNumber != 0)
        {
            numberInput.text = String(addedTrialGroup.trialGrNumber)
            commentInput.text = addedTrialGroup.comment
        }
        
        cropDropDown.anchorView = selectCrop
        
        cropDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.addedTrialGroup.cropName = item
        }
        
        let myCompHand:(Data?, URLResponse?, Error?) -> Void = { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            if let array = json as? [[String:Any]] {
                for object in array {
                    self.crops.append(object["CropName"] as! String)
                }
            }
        }
        self.getData(url:"http://localhost:8000/data/Weeds.json", myCompletionHandler: myCompHand)
        print(self.crops)
    }
    
    func getData(url: String, myCompletionHandler: Any?){
        let urlString = url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: myCompletionHandler as! (Data?, URLResponse?, Error?) -> Void).resume()
    }
    
    @IBAction func weedDropDownClick(_ sender: Any) {
        cropDropDown.dataSource = crops
        cropDropDown.show()
    }
    
    final class TrialGroupProduct
    {
        var name: String = ""
        var dose: String = ""
        var unit : String = ""
        
        init(_name:String, _dose:String, _unit:String)
        {
            name = _name
            dose = _dose
            unit = _unit
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var frameY:CGFloat = 187
        
        for treatment in addedTrialGroup.treatments{
            var products = [TrialGroupProduct]()
            var logChemDose:String = ""
            
            for product in treatment.products
            {
                var added = false
                let trialGroupProduct = TrialGroupProduct(_name: product.name, _dose: (product.dose as NSNumber).stringValue, _unit: product.unit)
                
                for newProduct in products
                {
                    if(newProduct.name == trialGroupProduct.name)
                    {
                        if(logChemDose == "")
                        {
                            logChemDose += newProduct.dose + " ! " + (product.dose as NSNumber).stringValue + " ! "
                        }
                        else
                        {
                            logChemDose += (product.dose as NSNumber).stringValue + " ! "
                        }
                        newProduct.dose = logChemDose
                        print(newProduct.dose)
                        added = true
                    }
                }
                if(!added)
                {
                    products.append(trialGroupProduct)
                }
            }
            
            let stageViewCopy = stageView.copyView()
            stageViewCopy.isHidden = false
            stageViewCopy.frame.origin.x = 0
            stageViewCopy.frame.origin.y = frameY
            (stageViewCopy.subviews[0] as! UILabel).text = "Stage " + treatment.treatmentStage
            if (treatment.treatmentDate != "")
            {
                (stageViewCopy.subviews[1] as! UILabel).text = treatment.treatmentDate
            }
            else
            {
                (stageViewCopy.subviews[1] as! UILabel).text = "N/A"
            }
            scrollView.addSubview(stageViewCopy)
            frameY += stageViewCopy.frame.size.height
            
            
            for product in products
            {
                let chemicalViewCopy = productsView.copyView()
                chemicalViewCopy.isHidden = false
                chemicalViewCopy.frame.origin.x = 0
                chemicalViewCopy.frame.origin.y = frameY
                (chemicalViewCopy.subviews[0] as! UILabel).text = product.name
                (chemicalViewCopy.subviews[1] as! UILabel).text = product.dose
                scrollView.addSubview(chemicalViewCopy)
                frameY += chemicalViewCopy.frame.size.height
                
            }
            let treatmentCommentViewCopy = treatmentCommentView.copyView()
            treatmentCommentViewCopy.isHidden = false
            treatmentCommentViewCopy.frame.origin.x = 0
            treatmentCommentViewCopy.frame.origin.y = frameY
            (treatmentCommentViewCopy.subviews[1] as! UILabel).text = treatment.comment
            scrollView.addSubview(treatmentCommentViewCopy)
            frameY += treatmentCommentViewCopy.frame.size.height
        }
        
        scrollView.contentSize = CGSize(width: 375, height: frameY)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
