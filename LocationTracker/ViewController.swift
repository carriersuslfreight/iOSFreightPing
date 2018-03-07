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
        
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(self.removeKeyboard))
        self.view.addGestureRecognizer(tapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func sendLocation(_ sender: Any) {
        if let number = self.cellField.text?.digits {
            if number.count == 10 {
                PhoneNumber.savePhoneNumber(number)
                LocationManager.shared.isUpdating ? LocationManager.shared.stop() : LocationManager.shared.start()
                LocationManager.shared.isUpdating ? self.locationButton.setTitle("Stop Tracking", for: .normal) : self.locationButton.setTitle("Start Tracking", for: .normal)
            } else {
                let alertController = UIAlertController.init(title: "Error", message: "Invalid Phone Number", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    @objc
    func removeKeyboard() {
        self.cellField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !string.containsDigits && string != "" {
            return false
        }

        if let text = textField.text, let textRange = Range(range, in: text) {            
            self.cellField.text = text.replacingCharacters(in: textRange, with: string)
            if let number = self.cellField.text, let phonenumber = PhoneNumber.format(phoneNumber: number) {
                self.cellField.text = phonenumber
            }
            return false
        }
        
        return true
    }
}


extension String {
    var digits: String { return components(separatedBy: CharacterSet.decimalDigits.inverted).joined() }
    var containsDigits: Bool { return self.digits != "" }
    
    func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}

