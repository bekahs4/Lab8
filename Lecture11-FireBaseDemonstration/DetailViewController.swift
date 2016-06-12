//
//  DetailViewController.swift
//  Lecture11-FireBaseDemonstration
//
//  Created by Jonathan Engelsma on 6/7/16.
//  Copyright © 2016 Jonathan Engelsma. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var delegate : MasterDelegate?
    @IBOutlet weak var entryField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate!.setNewEntry(self.entryField.text!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

