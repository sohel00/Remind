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
    
    func authorize(){
        
        let options:UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        
    }
}
