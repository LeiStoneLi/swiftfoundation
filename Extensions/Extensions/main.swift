//
//  main.swift
//  Extensions
//
//  Created by SrearAlex on 2017/2/9.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import Foundation

extension String {
    func addRandomWord() -> String {
        let value = arc4random_uniform(3)
        print("The value is \(value)")
        let word: String
        switch value {
        case 0:
            word = "rabbit"
        case 1:
            word = "banana"
        case 2:
            word = "boat"
        default:
            word = ""
        }
        return self + word
    }
}

let someString = "Hello, "
let result = someString.addRandomWord()
print("The queen says: \(result)")
