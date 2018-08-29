//
//  PasswordTextField.swift
//  PwdTextFieldTest
//
//  Created by SrearAlex on 2017/7/19.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit

class PasswordTextField: UITextField {
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
//                _ = becomeFirstResponder()
                reInsert()
            }
        }
    }
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        let needReInsert = !isFirstResponder && isSecureTextEntry
        print("needReInsert:\(needReInsert)")
        let success = super.becomeFirstResponder()
//        if needReInsert, let text = self.text {
//            self.text?.removeAll()
//            insertText(text)
//        }
        if needReInsert {
            reInsert()
        }
        return success
    }
    
    func reInsert() {
        if let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
    }
    
}
