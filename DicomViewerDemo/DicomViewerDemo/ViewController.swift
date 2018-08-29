//
//  ViewController.swift
//  DicomViewerDemo
//
//  Created by SrearAlex on 2018/8/17.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var modality: UILabel!
    @IBOutlet weak var dicomPlayView: DicomPlayView!
    @IBOutlet weak var dicom2DView: Dicom2DView!
    @IBOutlet weak var windowInfo: UILabel!
    @IBOutlet weak var date: UILabel!
    var dicomDecoder: DicomDecoder!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dicomPath = Bundle.main.path(forResource: "test2", ofType: nil)
        self.dicomPlayView.decodeAndDisplay(dicomPath)
        
//        var info = dicomDecoder.info(for: PATIENT_NAME)
//        self.patientName.text = "Patient: \(info)"
//
//        info = dicomDecoder.info(for: MODALITY)
//        self.patientName.text = "Modality: \(info)"
//
//        self.patientName.text = dicomDecoder.info(for: SERIES_DATE)

//        self.patientName.text = "WW/WL: \(dicom2DView.winWidth) / \(dicom2DView.winCenter)"

        
        // Add gesture
        //
        //    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
        //    panGesture.maximumNumberOfTouches = 1;
        //    [dicom2DView addGestureRecognizer:panGesture];
        //    [panGesture release];
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


