//
//  AppDelegate.swift
//  Nadam
//
//  Created by Taein Kim on 2021/02/21.
//

import CoreData
import HeroCommon
import HeroUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationVC = HeroNavigationController(navigationBarClass: HeroUINavigationBar.self, toolbarClass: nil)
        navigationVC.viewControllers = [MainTabBarViewController()]
        
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YappHero")
        container.loadPersistentStores(completionHandler: { _, error in
            // _를 storeDescription로 바꿔서 사용한다.
            if let error = error as NSError? {
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
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
