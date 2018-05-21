//
//  TrialGroupViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 14.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

public extension UIView
{
    func copyView<T: UIView>() -> T {
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
    }
}

class TrialGroupViewController: UIViewController {
    var selectedTrialGroup = [String:Any]()
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var weedTypeLabel: UILabel!
    @IBOutlet weak var trGroupComment: UILabel!
    
    @IBOutlet weak var treatmentCommentView: UIView!
    @IBOutlet weak var stageView: UIView!
    @IBOutlet weak var chemicalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var frameY:CGFloat = 187
        weedTypeLabel.text = selectedTrialGroup["CropName"] as? String
        trGroupComment.text = selectedTrialGroup["Comment"] as? String
        
        var stages = [[String:Any]]()
        
        var logDosages = [Decimal]()
        for treatment in (selectedTrialGroup["Treatments"] as! [[String:Any]]) {
            var found = stages.contains {
                ($0["Id"] as! NSNumber).intValue == (treatment["TreatmentID"] as! NSNumber).intValue
            }
            
            if (found == false) {
                stages.append(["Id":treatment["TreatmentID"] as Any,"StageName":treatment["TreatmentStage"] as Any, "StageDate":treatment["TreatmentDate"] as Any, "StageComment":treatment["Comment"] as Any,"Products":[[String:Any]]()])
            }
            var newStages = [[String:Any]]()
            for var stage in stages
            {
                var stageProducts = stage["Products"] as! [[String:Any]]
                if ((stage["Id"] as! NSNumber) == (treatment["TreatmentID"] as! NSNumber)) {
                    var dose:Any
                    if (treatment["DoseLog"] as! Bool == true)
                    {
                        dose = "LOG"
                        logDosages.append((treatment["ProductDose"] as! NSNumber).decimalValue)
                    }
                    else
                    {
                        dose = (treatment["ProductDose"] as! NSNumber).stringValue
                    }
                    found = stageProducts.contains
                    {
                        ($0["ProductName"] as! String) == (treatment["ProductName"] as! String)
                    }
                    
                    if (found == false)
                    {
                        stageProducts.append(["ProductName":treatment["ProductName"] as Any,"Dosage":dose as Any])
                    }
                }
                stage["Products"] = stageProducts
                var logDosageTxt = ""
                logDosages.sort(by: { $0 > $1 })
                for logChemDosage in logDosages{
                    
                    logDosageTxt += (logChemDosage as NSNumber).stringValue + " | "
                }
                logDosageTxt.removeLast(2)
                stage["LogChemTxt"] = logDosageTxt + " ml"
                newStages.append(stage)
            }
            stages = newStages;
        }
        
        for stage in stages{
            let stageViewCopy = stageView.copyView()
            stageViewCopy.isHidden = false
            stageViewCopy.frame.origin.x = 0
            stageViewCopy.frame.origin.y = frameY
            (stageViewCopy.subviews[0] as! UILabel).text = "Stage " + (stage["StageName"] as! String)
            if let date = (stage["StageDate"] as? String)
            {
                (stageViewCopy.subviews[1] as! UILabel).text = date
            }
            else
            {
                (stageViewCopy.subviews[1] as! UILabel).text = "N/A"
            }
            scrollView.addSubview(stageViewCopy)
            frameY += stageViewCopy.frame.size.height
            for product in stage["Products"] as! [[String:Any]]
            {
                let chemicalViewCopy = chemicalView.copyView()
                chemicalViewCopy.isHidden = false
                chemicalViewCopy.frame.origin.x = 0
                chemicalViewCopy.frame.origin.y = frameY
                (chemicalViewCopy.subviews[0] as! UILabel).text = (product["ProductName"] as! String)
                
                if (product["Dosage"] as! String) == "LOG"{
                 (chemicalViewCopy.subviews[1] as! UILabel).text = (stage["LogChemTxt"] as! String)
                }
                else{
                    (chemicalViewCopy.subviews[1] as! UILabel).text = (product["Dosage"] as! String)
                }
                scrollView.addSubview(chemicalViewCopy)
                frameY += chemicalViewCopy.frame.size.height
                    
            }
            let treatmentCommentViewCopy = treatmentCommentView.copyView()
            treatmentCommentViewCopy.isHidden = false
            treatmentCommentViewCopy.frame.origin.x = 0
            treatmentCommentViewCopy.frame.origin.y = frameY
            (treatmentCommentViewCopy.subviews[1] as! UILabel).text = (stage["StageComment"] as! String)
            scrollView.addSubview(treatmentCommentViewCopy)
            frameY += treatmentCommentViewCopy.frame.size.height
        }
        
        scrollView.contentSize = CGSize(width: 375, height: frameY)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func didUnwindToTrialGroupView(_ sender: UIStoryboardSegue){
    }

}
