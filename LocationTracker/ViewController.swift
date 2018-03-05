//
//  ViewController.swift
//  LocationTracker
//
//  Created by Peter Gosling on 7/26/17.
//  Copyright © 2017 Peter Gosling. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var cellField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LocationManager.shared
        self.locationButton.layer.cornerRadius = 3.0
        self.locationButton.layer.borderColor = UIColor.lightGray.cgColor
        self.locationButton.layer.borderWidth = 1.0
        self.cellField.layer.borderColor = UIColor.lightGray.cgColor
        self.cellField.layer.cornerRadius = 3.0
        self.cellField.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendLocation(_ sender: Any) {
        LocationManager.shared.start()
    }
}

