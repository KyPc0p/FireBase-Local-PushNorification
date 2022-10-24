//
//  Notifications.swift
//  Notification - LifeCycle
//
//  Created by Артём Харченко on 24.10.2022.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
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
            print("Notification settings \(settings)")
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
    
    //позволяет показать уведомление при открытом приложении
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound])
    }
    //реагирует на нажатие по уведомлению
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //some code
        
        completionHandler()
    }
}
