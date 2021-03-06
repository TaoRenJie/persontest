//
//  AppDelegate.swift
//  PersonalTest
//
//  Created by taorenjie on 2017/8/1.
//  Copyright © 2017年 tt. All rights reserved.
//

import UIKit
import CoreData
import Onboard.OnboardingViewController

//        骚操作 窗口上永远加一个东西
//        if view2.superview == nil{
//            UIApplication.shared.keyWindow?.addSubview(view2)
//        }
//        UIApplication.shared.keyWindow?.bringSubview(toFront: view2)
//        view2.isHidden = false
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if (!(UserDefaults.standard.bool(forKey: "everLaunched"))) {
            UserDefaults.standard.set(true, forKey:"everLaunched")
            self.loadFirstViewController()
        } else {
            self.jumpToMainViewController()
        }
        return true
    }

    func loadFirstViewController() {
        let firstPage = OnboardingContentViewController(title: nil, body: "Fuck the world.", image: nil, buttonText: nil) { () -> Void in}
//        let imageVIew: UIImageView = UIImageView()
//        imageVIew.frame = CGRect(x: 0,y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//        imageVIew.image = UIImage(named: "milky_way")
//        firstPage.view.addSubview(imageVIew)
        let secondPage = OnboardingContentViewController(title: nil, body: "I am a panda.", image: nil, buttonText: nil) { () -> Void in}
        let thirdPage = OnboardingContentViewController(title: "Ready?", body: nil, image: nil, buttonText: "Now,Fuck yourself") { () -> Void in
            self.jumpToMainViewController()
        }
        let onboardingVC = OnboardingViewController(backgroundImage: UIImage(named: "milky_way"), contents: [firstPage,secondPage,thirdPage])
        onboardingVC?.shouldMaskBackground = false
        self.window?.rootViewController = onboardingVC
         window?.makeKeyAndVisible()
    }

    func jumpToMainViewController() {
        let mainStoryboard = UIStoryboard(name:"Main", bundle:nil)
        guard let nav = mainStoryboard.instantiateViewController(withIdentifier: "Nav") as? TtNavigationController else {
            return
        }
        self.window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PersonalTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

