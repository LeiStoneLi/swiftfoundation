//
//  ViewController.swift
//  SDWebImageDemo
//
//  Created by SrearAlex on 2018/7/3.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
       var placeHolder: UIImage?
        let modifier = AnyModifier { request in
            var r = request
            if let URLString = r.url?.absoluteString {
                let hash = KingfisherManager.shared.cache.hash(forKey: URLString)
                if let dictionary = UserDefaults.standard.dictionary(forKey: "image-etags"),
                    let etag = dictionary[hash] as? String {
                    print("etag"+etag)
                    if KingfisherManager.shared.cache.imageCachedType(forKey: URLString) != .none {
                        r.setValue(etag, forHTTPHeaderField: "If-None-Match")
                    }
                }
            }

//            if let URLString = request.url?.absoluteString {
//                print(URLString)
//                let fm: FileManager = FileManager()
//                let imgKey = KingfisherManager.shared.cache.hash(forKey: URLString)
//                print(imgKey)
//                let imgPath = KingfisherManager.shared.cache.cachePath(forComputedKey: URLString)
//                print(imgPath)
//                print(fm.fileExists(atPath: imgPath))
//                do{
//                    let fileAttr = try fm.attributesOfItem(atPath: imgPath)
//                    var lastModifiedDate: Date? = nil
//
//                    if (fileAttr.count > 0) {
//                        lastModifiedDate = fileAttr[FileAttributeKey.modificationDate] as? Date
//                    }
//                    print(lastModifiedDate)
//                    let formatter = DateFormatter()
//                    formatter.timeZone = TimeZone(abbreviation: "GMT")
//                    formatter.locale = Locale(identifier: "en_US")
//                    formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
//                    if let lastMD = lastModifiedDate {
//                        var lastModifiedStr = formatter.string(from: lastMD)
//                        lastModifiedStr = lastModifiedStr.count > 0 ? lastModifiedStr : ""
//                        print(lastModifiedStr)
//                        r.setValue(lastModifiedStr,forHTTPHeaderField:"If-Modified-Since")
//                    }
//                } catch let error as NSError {
//                    print(error.localizedDescription)
//                }
//            }
            return r
        }
//        imageView.kf.setImage(with: URL(string: "https://cn.telepath-cloud.net/app/getExpertImage.action?hospitalID=Cleveland.Clinic&expertName=Claudiu.Cotta"), placeholder: nil, options: [.requestModifier(modifier)], progressBlock: nil, completionHandler: nil)
        placeHolder = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: "http://kr1.bingshenginc.com/app/getHospitalImage.action?hospitalID=Dian.diagnostics")
        imageView.kf.setImage(with: URL(string: "http://kr1.bingshenginc.com/app/getHospitalImage.action?hospitalID=Dian.diagnostics"), placeholder: placeHolder, options: [.requestModifier(modifier), .forceRefresh], progressBlock: nil){
            (image, _, _, _) in
            if let image = image {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    print("设置")
                   self.imageView.image = image
                }

            }
        }
//        [.requestModifier(modifier),.forceRefresh]
        // Do any additional setup after loading the view.
    }

    deinit {
        print(#file, #function)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
