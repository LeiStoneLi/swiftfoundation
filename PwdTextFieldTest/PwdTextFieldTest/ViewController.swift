//
//  ViewController.swift
//  PwdTextFieldTest
//
//  Created by SrearAlex on 2017/7/19.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textField: PasswordTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func hideKeyboard(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeTextFieldSecure() {
        if textField.isSecureTextEntry {
            textField.isSecureTextEntry = false
        } else {
            textField.isSecureTextEntry = true
        }
    }
}

