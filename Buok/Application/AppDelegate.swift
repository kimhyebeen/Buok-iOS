//
//  AppDelegate.swift
//  Nadam
//
//  Copyright © 2021 Buok. All rights reserved.
//

import CoreData
import Firebase
import FirebaseMessaging
import GoogleSignIn
import HeroCommon
import HeroUI
import KakaoSDKAuth
import KakaoSDKCommon

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        
        KakaoSDKCommon.initSDK(appKey: "e562ad6efc1a2a2c2ecc7e71cc3f8e3b")
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { _, _ in })
        application.registerForRemoteNotifications()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let startDIContainer = StartDIContainer()
        let startCoordinator = StartCoordinator(startDIContainer: startDIContainer)
        let splashViewModel = SplashViewModel(coordinator: startCoordinator)
        let splashVC = SplashViewController(viewModel: splashViewModel)
        
        window.rootViewController = splashVC
        window.makeKeyAndVisible()
        window.overrideUserInterfaceStyle = .light
        self.window = window
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        // App Scheme
        if AuthApi.isKakaoTalkLoginUrl(url) {
            return AuthController.handleOpenUrl(url: url)
        }
        
        return GIDSignIn.sharedInstance().handle(url)
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

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        DebugLog("[Push] userInfo : \(userInfo)")
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Messaging.messaging().appDidReceiveMessage(userInfo)
        DebugLog("[Push] didReceiveRemoteNotification")
        completionHandler(.noData)
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        DebugLog("Firebase registration token: \(fcmToken ?? "nil")")
        if let token = fcmToken {
            _ = TokenManager.shared.setFCMToken(token: token)
            let dataDict: [String: String] = ["token": token]
            NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        }
    }
}
