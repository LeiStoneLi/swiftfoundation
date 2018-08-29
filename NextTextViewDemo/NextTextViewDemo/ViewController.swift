//
//  ViewController.swift
//  NextTextViewDemo
//
//  Created by SrearAlex on 2017/3/3.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.textField {
            textView.becomeFirstResponder()
            return false
        }
        return true
    }
}
