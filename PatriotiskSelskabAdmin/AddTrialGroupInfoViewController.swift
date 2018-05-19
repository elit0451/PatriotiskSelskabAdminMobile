//
//  TrialGroupInfoViewController.swift
//  PatriotiskSelskabAdmin
//
//  Created by Elitsa Marinovska on 17.05.18.
//  Copyright © 2018 Elitsa Marinovska. All rights reserved.
//

import UIKit

class AddTrialGroupInfoViewController: UIViewController {

    var addedTrialGroup = TrialGroup()
    @IBOutlet weak var numberInput: UITextField!
    @IBOutlet weak var commentInput: UITextField!
    @IBOutlet weak var selectCrop: UIButton!
    
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
