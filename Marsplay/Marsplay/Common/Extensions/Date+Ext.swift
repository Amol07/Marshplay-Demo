//
//  Date+Ext.swift
//  Marsplay
//
//  Created by Amol Prakash on 24/01/20.
//  Copyright © 2020 Amol Prakash. All rights reserved.
//

import Foundation

extension Date {
    
    func timeAgo(since date: Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags = Set<Calendar.Component>([.day,.weekOfYear,.month,.year])
        let now = Date()
        let earliest = now < self ? now : self
        let latest = (earliest == now) ? self : now
        
        let components = calendar.dateComponents(unitFlags, from: earliest, to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1) {
            return "Last year"
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1) {
            return "Last month"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1) {
            return "Last week"
        } else if (components.day! > 0) {
            if (components.day! > 1) {
                return "\(components.day!) days ago"
            } else {
                return "Yesterday"
            }
        } else {
            return "Today"
        }
    }
    
    func earlierDate(_ date:Date) -> Date {
        return (self.timeIntervalSince1970 <= date.timeIntervalSince1970) ? self : date
    }
}
