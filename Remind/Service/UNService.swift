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
    
    func getAttachment(for id: NotificationAttachmentID) -> UNNotificationAttachment? {
        
        var image: String
        switch id{
            
        case .timer : image = "TimeAlert"
        case .date: image = "DateAlert"
        case .location: image = "LocationAlert"
        }
        
        guard let url = Bundle.main.url(forResource: image, withExtension: "png") else {return nil}
        
        do{
            let attachment = try UNNotificationAttachment(identifier: id.rawValue, url: url)
            return attachment
        } catch{
            return nil
        }
       
    }
    
    func timerRequest(interval: TimeInterval) {
        
        let content = UNMutableNotificationContent()
        content.title = "Timer Finished"
        content.body = "Your timer is all done. YAY!"
        content.sound = .default
        content.badge = 1
        
        if let attachment = getAttachment(for: .timer){
            content.attachments = [attachment]
        }
        
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
        
        if let attachment = getAttachment(for: .date){
            content.attachments = [attachment]
        }
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.Date", content: content, trigger: trigger)
        
        UNCentre.add(request)
    }
    
    func locationRequest(){
        
        let content = UNMutableNotificationContent()
        content.title = "Location Trigger"
        content.body = "Welcome Back!"
        content.sound = .default
        content.badge = 1
        
        if let attachment = getAttachment(for: .location){
            content.attachments = [attachment]
        }
        
        let request = UNNotificationRequest(identifier: "userNotification.Location", content: content, trigger: nil)
        UNCentre.add(request)
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
