//
//  String+AddText.swift
//  MyLocations
//
//  Created by SrearAlex on 2017/2/9.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import Foundation

extension String {
    mutating func add(text: String?, separatedBy separator: String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}
