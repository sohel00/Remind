//
//  ViewController.swift
//  Remind
//
//  Created by SD on 30/10/18.
//  Copyright © 2018 Sohel Dhengre. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNService.shared.authorize()
    }

    @IBAction func onTimerTapped(_ sender: Any) {
        print("Timer")
        AlertService.actionSheet(in: self, title: "5 Seconds") { () -> (Void) in
            UNService.shared.timerRequest(interval: 5)

        }
    }
    
    @IBAction func onDateTapped(_ sender: Any) {
        print("Date")
        AlertService.actionSheet(in: self, title: "Some Future Time!") { () -> (Void) in
            var component = DateComponents()
            component.second = 0
            
            UNService.shared.dateRequest(date: component)
        }
    }
    
    @IBAction func onLocationTapped(_ sender: Any) {
        print("Location")
        AlertService.actionSheet(in: self, title: "Location") { () -> (Void) in
            
        }
    }
    
}

