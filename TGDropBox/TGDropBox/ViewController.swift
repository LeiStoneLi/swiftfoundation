//
//  ViewController.swift
//  TGDropBox
//
//  Created by SrearAlex on 2017/1/18.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        let defaultTitle = "全部科室"
        let choices = ["全部科室", "乳腺病理", "心血管病理", "细胞病理", "胃肠道病理", "妇科病理", "头颈部病理", "血液病理", "神经病理", "眼科病理", "骨整形外科病理", "胰腺胆囊病理", "儿科病理", "肺病理", "肾病理", "软组织病理", "泌尿病理"]
        let rect = CGRect(x: 15, y: 79, width: self.view.frame.width - 30, height: 22)
        let dropBoxView = TGDropBoxView(parentVC: self, title: defaultTitle, items: choices, frame: rect)
        dropBoxView.isHightWhenShowList = true
        dropBoxView.willShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("will show choices") }
            else { NSLog("will hide choices") }
        }
        dropBoxView.didShowOrHideBoxListHandler = { (isShow) in
            if isShow { NSLog("did show choices") }
            else { NSLog("did hide choices") }
        }
        dropBoxView.didSelectBoxItemHandler = { (row) in
            NSLog("selected No.\(row): \(dropBoxView.currentTitle())")
        }
        self.view.addSubview(dropBoxView)
        self.view.bringSubview(toFront: dropBoxView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

