//
//  AddTreatmentViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 19.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddTreatmentViewController: UIViewController {
    
    var addedTrialGroup = TrialGroup()
    var products = [Product]()
    
    @IBOutlet weak var stageInput: UITextField!
    @IBOutlet weak var dateInput: UITextField!
    @IBOutlet weak var logChemNameInput: UITextField!
    @IBOutlet weak var logChemDosage1Input: UITextField!
    @IBOutlet weak var logChemDosage2Input: UITextField!
    @IBOutlet weak var logChemDosage3Input: UITextField!
    @IBOutlet weak var logChemDosage4Input: UITextField!
    @IBOutlet weak var logChemDosage5Input: UITextField!
    @IBOutlet weak var logChemUnitInput: UITextField!
    @IBOutlet weak var regularChemNameInput: UITextField!
    @IBOutlet weak var regularChemDosageInput: UITextField!
    @IBOutlet weak var regularChemUnitInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    
    @IBOutlet weak var productsScrollView: UIScrollView!
    @IBOutlet weak var productView: UIView!
    
    @IBAction func addProduct(_ sender: Any) {
        guard let chemName = regularChemNameInput.text else { return }
        guard let chemDosage = Decimal.init(string: regularChemDosageInput.text!) else { return }
        guard let chemUnit = regularChemUnitInput.text else { return }
        products.append(Product(name: chemName, dose: chemDosage, unit: chemUnit))
        
        regularChemNameInput.text = ""
        regularChemDosageInput.text = ""
        regularChemUnitInput.text = ""
        
        refreshProductScrollView()
    }
    
    @IBAction func addTreatment(_ sender: Any) {
        var doseLog = false
        guard let stageName = stageInput.text else { return }
        guard let date = dateInput.text else { return }
        guard let comment = commentInput.text else { return }
        if(logChemNameInput.text != nil)
        {
            guard let chemName = logChemNameInput.text else { return }
            guard let chemDosage1 = Decimal.init(string: logChemDosage1Input.text!) else { return }
            guard let chemDosage2 = Decimal.init(string: logChemDosage2Input.text!) else { return }
            guard let chemDosage3 = Decimal.init(string: logChemDosage3Input.text!) else { return }
            guard let chemDosage4 = Decimal.init(string: logChemDosage4Input.text!) else { return }
            guard let chemDosage5 = Decimal.init(string: logChemDosage5Input.text!) else { return }
            guard let chemUnit = logChemUnitInput.text else { return }
            
            products.append(Product(name: chemName, dose: chemDosage1, unit: chemUnit))
            products.append(Product(name: chemName, dose: chemDosage2, unit: chemUnit))
            products.append(Product(name: chemName, dose: chemDosage3, unit: chemUnit))
            products.append(Product(name: chemName, dose: chemDosage4, unit: chemUnit))
            products.append(Product(name: chemName, dose: chemDosage5, unit: chemUnit))
            
            doseLog = true;
        }
        
        addedTrialGroup.treatments.append(Treatment(treatmentDate: date, treatmentStage: stageName, doseLog: doseLog, comment: comment, products: products))
        
        products.removeAll()
        stageInput.text = ""
        dateInput.text = ""
        logChemNameInput.text = ""
        logChemDosage1Input.text = ""
        logChemDosage2Input.text = ""
        logChemDosage3Input.text = ""
        logChemDosage4Input.text = ""
        logChemDosage5Input.text = ""
        logChemUnitInput.text = ""
        regularChemNameInput.text = ""
        regularChemDosageInput.text = ""
        regularChemUnitInput.text = ""
        commentInput.text = ""
        refreshProductScrollView()
    }
    
    func refreshProductScrollView()
    {
        var frameY:CGFloat = 0
        productsScrollView.contentSize = CGSize(width: 0, height: 0)
        for view in productsScrollView.subviews
        {
            if(view.isHidden == false)
            {
            view.removeFromSuperview()
            }
        }
        for product in products
        {
            let productViewCopy = productView.copyView()
            productViewCopy.isHidden = false
            productViewCopy.frame.origin.x = 0
            productViewCopy.frame.origin.y = frameY
            (productViewCopy.subviews[0] as! UILabel).text = product.name
            (productViewCopy.subviews[1] as! UILabel).text = (product.dose as NSNumber).stringValue + " " + product.unit
            
            productsScrollView.addSubview(productViewCopy)
            frameY += productViewCopy.frame.size.height
        }
        
        productsScrollView.contentSize = CGSize(width: 323, height: frameY)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
