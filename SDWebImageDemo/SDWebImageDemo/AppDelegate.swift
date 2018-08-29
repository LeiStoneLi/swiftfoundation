//
//  AppDelegate.swift
//  SDWebImageDemo
//
//  Created by SrearAlex on 2018/7/3.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        KingfisherManager.shared.downloader.delegate = self
//        ImageCache.default.maxCachePeriodInSecond = 60
        /*
        let imgDownloader = SDWebImageManager.shared().imageDownloader
        imgDownloader?.headersFilter  = {((url: URL?, headers: Dictionary?<String, String>) -> Dictionary?<String, String>)? in
            let fm: FileManager = FileManager()
            let imgKey = SDWebImageManager.shared().cacheKey(for: url)
            let imgPath = SDWebImageManager.shared().imageCache?.defaultCachePath(forKey: imgKey)
            let fileAttr = try fm.attributesOfItem(atPath: imgPath!)
            let mutableHeaders = headers
            let lastModifiedDate: Date? = nil
            
            if (fileAttr.count > 0) {
                lastModifiedDate = fileAttr[FileModificationDate]
            }
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(abbreviation: "GMT")
            formatter.locale = Locale(identifier: "en_US")
            formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
            let lastModifiedStr = formatter.string(from: lastModifiedDate)
            lastModifiedStr = lastModifedStr.lenght > 0 ? lastModifiedStr:""
            mutableHeaders.set(lastModifiedStr,forKey:"If-Modified-Since")
            
            return mutableHeaders
        }
        KingfisherManager.shared.downloader.requestModifier = {
            (request: NSMutableURLRequest) in
            
            if let URLString = request.URL?.absoluteString {
                let hash = KingfisherManager.sharedManager.cache.hashForKey(URLString)
                let fm: FileManager = FileManager()
                let imgKey = SDWebImageManager.shared().cacheKey(for: URLString)
                let imgPath = SDWebImageManager.shared().imageCache?.defaultCachePath(forKey: imgKey)
                let fileAttr = try fm.attributesOfItem(atPath: imgPath!)
                let mutableHeaders = headers
                let lastModifiedDate: Date? = nil
                
                if (fileAttr.count > 0) {
                    lastModifiedDate = fileAttr[FileModificationDate]
                }
                let formatter = DateFormatter()
                formatter.timeZone = TimeZone(abbreviation: "GMT")
                formatter.locale = Locale(identifier: "en_US")
                formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss z"
                let lastModifiedStr = formatter.string(from: lastModifiedDate)
                lastModifiedStr = lastModifedStr.lenght > 0 ? lastModifiedStr:""
                request.setValue(lastModifiedStr,forKey:"If-Modified-Since")
            }
        }
         */
        NotificationCenter.default.addObserver(self, selector: #selector(diskImageCacheCleaned(notification:)),
                                                         name: Notification.Name.KingfisherDidCleanDiskCache, object: KingfisherManager.shared.cache)
        
        
        return true
    }
    
    @objc func diskImageCacheCleaned(notification: NSNotification) {
        print("diskImageCacheCleaned")
        let dictionaryKey = "image-etags"
        
        let userDefaults = UserDefaults.standard
        if let dictionary = userDefaults.dictionary(forKey: dictionaryKey) as? [String: String],
            let hashes = notification.userInfo?[KingfisherDiskCacheCleanedHashKey] as? [String]
        {
            var result = dictionary
            for hash in hashes {
                result.removeValue(forKey: hash)
            }
            
            userDefaults.set(result, forKey: dictionaryKey)
            userDefaults.synchronize()
        }
    }

    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
}

extension AppDelegate: ImageDownloaderDelegate {
    func imageDownloader(_ downloader: ImageDownloader, didDownload image: Image, for url: URL, with response: URLResponse?) {
        print(url.absoluteString)
        print(response as? HTTPURLResponse)
        if let httpResponse = response as? HTTPURLResponse,
            let etag = httpResponse.allHeaderFields["Etag"] as? String {
            let URLString = url.absoluteString
            print(etag)
            let dictionaryKey = "image-etags"
            
            var dictionary = UserDefaults.standard.dictionary(forKey: dictionaryKey) as? [String: String]
            if dictionary == nil {
                dictionary = [String: String]()
            }
            
            let hash = KingfisherManager.shared.cache.hash(forKey:URLString)
            dictionary![hash] = etag
            UserDefaults.standard.set(dictionary, forKey: dictionaryKey)
            UserDefaults.standard.synchronize()
        }
    }
}


