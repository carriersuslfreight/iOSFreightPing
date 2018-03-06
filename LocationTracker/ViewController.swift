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
    let networking = Networking()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //LocationManager.shared
        self.locationButton.layer.cornerRadius = 3.0
        self.locationButton.layer.borderColor = UIColor.lightGray.cgColor
        self.locationButton.layer.borderWidth = 1.0
        self.cellField.layer.borderColor = UIColor.lightGray.cgColor
        self.cellField.layer.cornerRadius = 3.0
        self.cellField.layer.borderWidth = 1.0
        self.cellField.delegate = self
        networking.sendRequest(networking.reportLocationPostRequest("12345", "2154w")) { (result: Result<RecordLocationType>) in
            print(result)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendLocation(_ sender: Any) {
        LocationManager.shared.start()
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, let textRange = Range(range, in: text) { let phoneNumber = text.replacingCharacters(in: textRange, with: string)
            print(phoneNumber)
        }
        return true
    }
}

