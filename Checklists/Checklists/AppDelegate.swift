//
//  AppDelegate.swift
//  Checklists
//
//  Created by SrearAlex on 2017/1/5.
//  Copyright © 2017年 SrearAlex. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, UIAlertViewDelegate{

    var window: UIWindow?
    
    let dataModel = DataModel()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.dataModel = dataModel
        
        let center = UNUserNotificationCenter.current()
        /*
        center.requestAuthorization(options: [.alert, .sound]) {
            granted, error in
            if granted {
                print("We have persission")
            } else {
                print("Permission denied")
            }
        }
        let content = UNMutableNotificationContent()
        content.title = "Hello!"
        content.body = "I am a local notification"
        content.sound = UNNotificationSound.default()
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "MyNotification", content: content, trigger: trigger)
        center.add(request)
        */
        center.delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received local notification \(notification)")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        saveData()
    }

    /*
    func saveData() {
        let navigationController = window!.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! AllListsViewController
        controller.saveChecklists()
    }
    */
    
    func saveData() {
        dataModel.saveChecklists()
    }
    /*
    //MARK: - 检查更新
    let LOCAL_VERSION:String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    private func checkUpdate() {
        let path = NSString(format: "http://itunes.apple.com/cn/lookup?id=1104867082") as String
        let url = NSURL(string: path)
        let request = NSMutableURLRequest(url: url! as URL, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue()) { (response, data, error) in
            let receiveStatusDic = NSMutableDictionary()
            if data != nil {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                    if let resultCount = dic["resultCount"] as? NSNumber {
                        if resultCount.integerValue > 0 {
                            receiveStatusDic.setValue("1", forKey: "status")
                            if let arr = dic["results"] as? NSArray {
                                if let dict = arr.firstObject as? NSDictionary {
                                    if let version = dict["version"] as? String {
                                        receiveStatusDic.setValue(version, forKey: "version")
                                        UserDefaults.standardUserDefaults().setObject(version, forKey: "Version")
                                        UserDefaults.standard.synchronize()
                                    }
                                }
                            }
                        }
                    }
                }catch let error {
//                    log.debug("checkUpdate -------- \(error)")
                    print("checkUpdate -------- \(error)")
                    receiveStatusDic.setValue("0", forKey: "status")
                }
            }else {
                receiveStatusDic.setValue("0", forKey: "status")
            }
            self.performSelector(onMainThread: #selector(self.checkUpdateWithData), with: receiveStatusDic, waitUntilDone: false)
        }
    }
    
    @objc private func checkUpdateWithData(data: NSDictionary) {
        let status = data["status"] as? String
        if status == "1" {
            let storeVersion = data["version"] as! String
            self.compareVersion(localVersion: LOCAL_VERSION, storeVersion: storeVersion)
            return
        }
        if let storeVersion = UserDefaults.standard.object(forKey: "Version") as? String {
            self.compareVersion(localVersion: LOCAL_VERSION, storeVersion: storeVersion)
        }
    }
    
    private func compareVersion(localVersion: String, storeVersion: String) {
        if localVersion.compare(storeVersion) == ComparisonResult.orderedAscending {
            let alertView = UIAlertView(title: "",message: "有更强大的新版本啦，要更新嘛？",delegate: self,cancelButtonTitle: nil,otherButtonTitles: "马上更新","下次再说")
            alertView.delegate = self
            alertView.show()
            
        }
    }
    
    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        if(buttonIndex == 0){
            UIApplication.shared.openURL(NSURL(string:"itms-apps://itunes.apple.com/cn/app/xing-rui-yu-le/id你的appID?mt=8")! as URL)
        }else{
            //下次再说
        }
        
    }
    */
}

