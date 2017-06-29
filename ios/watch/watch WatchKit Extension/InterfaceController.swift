//
//  InterfaceController.swift
//  watch WatchKit Extension
//
//  Created by Mark Evans on 6/29/17.
//  Copyright © 2017 3Advance, LLC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var hoursImageView: WKInterfaceImage!
    @IBOutlet var minutesGroup: WKInterfaceGroup!

    var timer: Timer!
    var startSeconds: TimeInterval = 0
    var startMinutes: TimeInterval = 0
    var startHour: TimeInterval = 0

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    override func willActivate() {
        super.willActivate()

        initClock()
    }
    
    override func didDeactivate() {
        super.didDeactivate()

        timer.invalidate()
    }

    func timerAction(timer: Timer) {
        startSeconds += 1
        if startSeconds >= 60 {
            startSeconds = 0

            if Date().getCurrentHour() != startHour {
                hoursImageView.setImageNamed("watch_hours_\(Int(Date().getCurrentHour())).png")
            }
            if Date().getCurrentMinutes() != startMinutes {
                minutesGroup.setBackgroundImageNamed("watch_minutes_\(Int(Date().getCurrentMinutes())).png")
            }
        }
    }

    func initClock() {
        startHour = Date().getCurrentHour()
        startMinutes = Date().getCurrentMinutes()
        startSeconds = Date().getCurrentSeconds()

        hoursImageView.setImageNamed("watch_hours_\(Int(startHour)).png")
        minutesGroup.setBackgroundImageNamed("watch_minutes_\(Int(startMinutes)).png")

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerAction(timer:)), userInfo: nil, repeats: true)
    }

}

extension Date {
    func getCurrentHour() -> TimeInterval {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        calendar.locale = Locale.current
        return TimeInterval(calendar.component(.hour, from: currentDate))
    }

    func getCurrentMinutes() -> TimeInterval {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        calendar.locale = Locale.current
        return TimeInterval(calendar.component(.minute, from: currentDate))
    }

    func getCurrentSeconds() -> TimeInterval {
        let currentDate = Date()
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        calendar.locale = Locale.current
        return TimeInterval(calendar.component(.second, from: currentDate))
    }
}
