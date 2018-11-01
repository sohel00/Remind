//
//  UNService.swift
//  Remind
//
//  Created by SD on 30/10/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import Foundation
import UserNotifications

class UNService: NSObject{
    
    private override init() {}
    static let shared = UNService()
    
    let UNCentre = UNUserNotificationCenter.current()
    
    func authorize(){
        
        let options:UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        UNCentre.requestAuthorization(options: options) { (granted, error) in
            if granted {
                print("No UN Auth Error")
                self.configure()
            } else {
                print("User Denied Access")
            }
        }
        
    }
    
    func configure(){
        UNCentre.delegate = self
    }
    
    func timerRequest(interval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "usernotification.Timer", content: content, trigger: trigger)
        
        UNCentre.add(request)
    }
    
    func dateRequest(date: DateComponents){
        
        let content = UNMutableNotificationContent()
        content.title = "Date Trigger"
        content.body = "It is now the future!"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.Date", content: content, trigger: trigger)
        
        UNCentre.add(request)
    }
    
    func locationRequest(){
        
    }
}


extension UNService: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN Did receive response")
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present Notification")
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
    
}
