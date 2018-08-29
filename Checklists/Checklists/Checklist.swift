//
//  Checklist.swift
//  Checklists
//
//  Created by SrearAlex on 2017/1/9.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit

class Checklist: NSObject, NSCoding {
    var name = ""
//    var items: [ChecklistItem] = [ChecklistItem]()
//    var items: [ChecklistItem] = []
    var items = [ChecklistItem]()
    var iconName: String
    
    /*
    init(name: String) {
        self.name = name
        iconName = "No Icon"
        super.init()
    }
     */
    
    
    init(name: String, iconName: String) {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    convenience init(name: String) {
        self.init(name: name, iconName: "No Icon")
    }

    required init?(coder aDecoder: NSCoder) {// NS_DESIGNATED_INITIALIZER
        name = aDecoder.decodeObject(forKey: "Name") as! String
        items = aDecoder.decodeObject(forKey: "Items") as! [ChecklistItem]
        iconName = aDecoder.decodeObject(forKey: "IconName") as! String
        super.init()
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(name, forKey: "Name")
        aCoder.encode(items, forKey: "Items")
        aCoder.encode(iconName, forKey: "IconName")
    }

    /*
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
     */
    func countUncheckedItems() -> Int {
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1) }
    }
}
