//
//  DicomViewController.swift
//  DicomViewerDemo
//
//  Created by SrearAlex on 2018/8/20.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit

class DicomViewController: UIViewController {
    @IBOutlet weak var dicomView: DicomView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let dicomPath = Bundle.main.path(forResource: "test1", ofType: "dcm")
        dicomView.dicomPlayView.decodeAndDisplay(dicomPath)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
