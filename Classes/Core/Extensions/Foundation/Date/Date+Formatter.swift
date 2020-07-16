//
//  Created by Komolbek Ibragimov on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

extension Date {
    
    func timeSinceDate(fromDate: Date) -> String {
        
        let earliest = self < fromDate ? self  : fromDate
        let latest = (earliest == self) ? fromDate : self
        let components:DateComponents = Calendar.current.dateComponents([.minute, .hour, .day,.weekOfYear, .month, .year, .second],
                                                                        from: earliest,
                                                                        to: latest)
        
        let year = components.year  ?? 0
        let month = components.month  ?? 0
        let week = components.weekOfYear  ?? 0
        let day = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        if year >= 2 {
            return "\(year) years"
        } else if (year >= 1) {
            return "1 year"
        } else if (month >= 2) {
            return "\(month) months"
        } else if (month >= 1) {
            return "1 month"
        }else  if (week >= 2) {
            return "\(week) weeks"
        } else if (week >= 1) {
            return "1 week"
        } else if (day >= 2) {
            return "\(day) days"
        } else if (day >= 1) {
            return "1 day"
        } else if (hours >= 2) {
            return "\(hours) hours"
        } else if (hours >= 1) {
            return "1 hour"
        } else if (minutes >= 2) {
            return "\(minutes) minutes"
        } else if (minutes >= 1) {
            return "1 minute"
        } else if (seconds >= 3) {
            return "\(seconds) seconds"
        } else {
            return "Just now"
        }
    }
}

extension Date {
    
    static func currentDate() -> Date {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        return dateFormatter.string(from: date).stringToDate() ?? Date()
    }
}
