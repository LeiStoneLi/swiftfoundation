//
//  KSViewController.swift
//  DicomViewerDemo
//
//  Created by SrearAlex on 2018/8/20.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit

class KSViewController: UIViewController {
    @IBOutlet weak var patientName: UILabel!
    @IBOutlet weak var modality: UILabel!
    @IBOutlet weak var dicom2DView: Dicom2DView!
    @IBOutlet weak var windowInfo: UILabel!
    @IBOutlet weak var date: UILabel!
    var dicomDecoder: DicomDecoder!

    override func viewDidLoad() {
        super.viewDidLoad()
        let dicomPath = Bundle.main.path(forResource: "test1", ofType: "dcm")
        decodeAndDisplay(path: dicomPath!)
        var info = dicomDecoder.info(for: Int(PATIENT_NAME))
        self.patientName.text = "Patient: \(info!)"
        
        info = dicomDecoder.info(for: Int(MODALITY))
        self.modality.text = "Modality: \(info!)"
        
        self.date.text = dicomDecoder.info(for: Int(SERIES_DATE))
        
        self.windowInfo.text = "WW/WL: \(dicom2DView.winWidth) / \(dicom2DView.winCenter)"

        // Do any additional setup after loading the view.
    }
    func decodeAndDisplay(path: String) {
        dicomDecoder = DicomDecoder()
        dicomDecoder.setDicomFilename(path)
        display(windowWidth: dicomDecoder.windowWidth, windowCenter: dicomDecoder.windowCenter)
        
    }
    func display(windowWidth: NSInteger, windowCenter: NSInteger) {
        if (!dicomDecoder.dicomFound || !dicomDecoder.dicomFileReadSuccess) {
            dicomDecoder = nil
            return
        }
        var winWidth = windowWidth
        var winCenter = windowCenter
        let imageWidth = dicomDecoder.width
        let imageHeight = dicomDecoder.height
        let bitDepth = dicomDecoder.bitDepth
        let samplesPerPixel = dicomDecoder.samplesPerPixel
        let signedImage = dicomDecoder.signedImage
        
        var needsDisplay = false
        
        if samplesPerPixel == 1 && bitDepth == 8 {
            let pixels8 = dicomDecoder.getPixels8()
            if winWidth == 0 && winWidth == 0 {
                var max = 0, min = 255
                let num = imageWidth * imageHeight
                for i in 0..<num {
                    if (pixels8![i] > max) {
                        max = Int(pixels8![i])
                    }
                    if (pixels8![i] < min) {
                        min = Int(pixels8![i])
                    }
                }
                winWidth = NSInteger((Double)(max + min)/2.0 + 0.5)
                winCenter = NSInteger((Double)(max - min)/2.0 + 0.5)
            }
            dicom2DView.setPixels8(pixels8, width: imageWidth, height: imageHeight, windowWidth: Double(winWidth), windowCenter: Double(winCenter), samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if samplesPerPixel == 1 && bitDepth == 16 {
            let pixels16 = dicomDecoder.getPixels16()
            if winWidth == 0 || winCenter == 0 {
                var max = 0, min = 65535
                
                let num = imageWidth * imageHeight
                for i in 0..<num {
                    if (pixels16![i] > max) {
                        max = Int(pixels16![i])
                    }
                    if (pixels16![i] < min) {
                        min = Int(pixels16![i])
                    }
                }
                winWidth = NSInteger((Double)(max + min)/2.0 + 0.5)
                winCenter = NSInteger((Double)(max - min)/2.0 + 0.5)
            }
            dicom2DView.signed16Image = signedImage
            dicom2DView.setPixels16(pixels16, width: imageWidth, height: imageHeight, windowWidth: Double(winWidth), windowCenter: Double(winCenter), samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if samplesPerPixel == 3 && bitDepth == 8 {
            let pixels24 = dicomDecoder.getPixels24()
            if winWidth == 0 || winCenter == 0 {
                var max = 0, min = 255
                
                let num = imageWidth * imageHeight * 3
                for i in 0..<num {
                    if (pixels24![i] > max) {
                        max = Int(pixels24![i])
                    }
                    if (pixels24![i] < min) {
                        min = Int(pixels24![i])
                    }
                }
                winWidth = NSInteger((Double)(max + min)/2.0 + 0.5)
                winCenter = NSInteger((Double)(max - min)/2.0 + 0.5)
            }
            dicom2DView.setPixels8(pixels24, width: imageWidth, height: imageHeight, windowWidth: Double(winWidth), windowCenter: Double(winCenter), samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if needsDisplay {
            let x = (self.view.frame.size.width - CGFloat(imageWidth)) / 2
            let y = (self.view.frame.size.height - CGFloat(imageHeight)) / 2
            dicom2DView.frame = CGRect(x: x, y: y, width: CGFloat(imageWidth), height: CGFloat(imageHeight))
            dicom2DView.setNeedsDisplay()
            
            let info = String(format: "WW/WL: %d / %d", arguments: [dicom2DView.winWidth, dicom2DView.winCenter])
            print(info)
            self.windowInfo.text = info
        }
    }


    func display(windowWidth: Double, windowCenter: Double) {
        if (!dicomDecoder.dicomFound || !dicomDecoder.dicomFileReadSuccess) {
            dicomDecoder = nil
            return
        }
        var winWidth = windowWidth
        var winCenter = windowCenter
        let imageWidth = dicomDecoder.width
        let imageHeight = dicomDecoder.height
        let bitDepth = dicomDecoder.bitDepth
        let samplesPerPixel = dicomDecoder.samplesPerPixel
        let signedImage = dicomDecoder.signedImage

        var needsDisplay = false
        
        if samplesPerPixel == 1 && bitDepth == 8 {
            let pixels8 = dicomDecoder.getPixels8()
            if winWidth == 0 && winWidth == 0 {
                var max = 0, min = 255
                let num = imageWidth * imageHeight
                for i in 0..<num {
                    if (pixels8![i] > max) {
                        max = Int(pixels8![i])
                    }
                    if (pixels8![i] < min) {
                        min = Int(pixels8![i])
                    }
                }
                winWidth = (Double)(max + min)/2.0 + 0.5
                winCenter = (Double)(max - min)/2.0 + 0.5
            }
            dicom2DView.setPixels8(pixels8, width: imageWidth, height: imageHeight, windowWidth: winWidth, windowCenter: winCenter, samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if samplesPerPixel == 1 && bitDepth == 16 {
            let pixels16 = dicomDecoder.getPixels16()
            if winWidth == 0 || winCenter == 0 {
                var max = 0, min = 65535
                
                let num = imageWidth * imageHeight
                for i in 0..<num {
                    if (pixels16![i] > max) {
                        max = Int(pixels16![i])
                    }
                    if (pixels16![i] < min) {
                        min = Int(pixels16![i])
                    }
                }
                winWidth = (Double)(max + min)/2.0 + 0.5
                winCenter = (Double)(max - min)/2.0 + 0.5
            }
            dicom2DView.signed16Image = signedImage
            dicom2DView.setPixels16(pixels16, width: imageWidth, height: imageHeight, windowWidth: winWidth, windowCenter: winCenter, samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if samplesPerPixel == 3 && bitDepth == 8 {
            let pixels24 = dicomDecoder.getPixels24()
            if winWidth == 0 || winCenter == 0 {
                var max = 0, min = 255
                
                let num = imageWidth * imageHeight * 3
                for i in 0..<num {
                    if (pixels24![i] > max) {
                        max = Int(pixels24![i])
                    }
                    if (pixels24![i] < min) {
                        min = Int(pixels24![i])
                    }
                }
                winWidth = (Double)(max + min)/2.0 + 0.5
                winCenter = (Double)(max - min)/2.0 + 0.5
            }
            dicom2DView.setPixels8(pixels24, width: imageWidth, height: imageHeight, windowWidth: winWidth, windowCenter: winCenter, samplesPerPixel: samplesPerPixel, resetScroll: true)
            needsDisplay = true
        }
        
        if needsDisplay {
            let x = (self.view.frame.size.width - CGFloat(imageWidth)) / 2
            let y = (self.view.frame.size.height - CGFloat(imageHeight)) / 2
            dicom2DView.frame = CGRect(x: x, y: y, width: CGFloat(imageWidth), height: CGFloat(imageHeight))
            dicom2DView.setNeedsDisplay()
            
            let info = String(format: "WW/WL: %d / %d", arguments: [dicom2DView.winWidth, dicom2DView.winCenter])
            self.windowInfo.text = info
        }
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
