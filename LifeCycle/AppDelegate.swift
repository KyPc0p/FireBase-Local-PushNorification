//
//  AppDelegate.swift
//  LifeCycle
//
//  Created by Артём Харченко on 23.08.2022.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        requesAutorization()
        notificationCenter.delegate = self
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func requesAutorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission granted \(granted)")

            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        self.notificationCenter.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else { return }
//            print("Notification settings \(settings)")
        }
    }
    
    func sentNotification(with type: String) {
        let content = UNMutableNotificationContent()
        content.title = type
        content.body = "Был произведен тестовый вызов \(type)"
        content.sound = .default
        

        let identifier = "notification"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            print(error?.localizedDescription ?? "Error")
        }
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    //позволяет показать уведомление при открытом приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    //реагирует на нажатие по уведомлению
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //some code
        
        completionHandler()
    }
}

