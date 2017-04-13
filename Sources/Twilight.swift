//
//  Twilight.swift
//  Twilight
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation
import CSunriset

let secondsPerHour: TimeInterval = 3600

public final class Twilight {

    public typealias DateInterval = (start: Date, end: Date)
    
    let calendar: Calendar
    let UTCTimezone: TimeZone

    let dateComponents: DateComponents
    let longtitude: Double
    let latitude: Double
    
    /// Create Twilight object using specified parameters.
    ///
    /// - parameter date:       A date in the day to perform calculation on.
    /// - parameter timezone:   The timezone of the date. It's used to extract the year/month/day date components.
    /// - parameter longtitude: The longtitude of the location.
    /// - parameter latitude:   The latitude of the location.
    ///
    /// - returns: A Twilight object.
    public init(date: Date, timezone: TimeZone = TimeZone.current, longtitude: Double, latitude: Double) {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = timezone
        self.UTCTimezone = TimeZone(abbreviation: "UTC")!
        self.dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
        calendar.timeZone = UTCTimezone
        self.calendar = calendar
        self.longtitude = longtitude
        self.latitude = latitude
    }
}

public extension Twilight {
    
    private func calculateInterval(altitude: Double, isTwilight: Bool) -> DateInterval {
        let year = Int32(dateComponents.year!)
        let month = Int32(dateComponents.month!)
        let day = Int32(dateComponents.day!)
        
        var startOffset: Double = 0
        var endOffset: Double = 0
        sunriset(year, month, day, longtitude, latitude, altitude, isTwilight ? 0 : 1, &startOffset, &endOffset)
        
        let start = calendar.date(from: dateComponents)!.addingTimeInterval(startOffset * secondsPerHour)
        let end = calendar.date(from: dateComponents)!.addingTimeInterval(endOffset * secondsPerHour)
        return (start, end)
    }
    
    private func calculateIntervalLength(altitude: Double, isTwilight: Bool) -> TimeInterval {
        let year = Int32(dateComponents.year!)
        let month = Int32(dateComponents.month!)
        let day = Int32(dateComponents.day!)
        
        return daylen(year, month, day, longtitude, latitude, altitude, isTwilight ? 0 : 1) * secondsPerHour
    }
    
    
    /// Get start/end time of the day's daytime.
    func daytime() -> DateInterval {
        return calculateInterval(altitude: -35.0 / 60.0, isTwilight: false)
    }
    
    /// Get sunrise time of the day. This is a shortcut of `daytime().start`.
    func sunrise() -> Date {
        return daytime().start
    }
    
    /// Get sunset time of the day. This is a shortcut of `daytime().end`.
    func sunset() -> Date {
        return daytime().end
    }
    
    /// Get start/end time of the day's civil twilight.
    /// **Note**: For more information for twilight types, please refer to 
    /// [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)
    func civilTwilight() -> DateInterval {
        return calculateInterval(altitude: -6.0, isTwilight: true)
    }
    
    /// Get start/end time of the day's nautical twilight.
    /// **Note**: For more information for twilight types, please refer to
    /// [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)
    func nauticalTwilight() -> DateInterval {
        return calculateInterval(altitude: -12.0, isTwilight: true)
    }
    
    /// Get start/end time of the day's astronomical twilight.
    /// **Note**: For more information for twilight types, please refer to
    /// [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)
    func astronomicalTwilight() -> DateInterval {
        return calculateInterval(altitude: -12.0, isTwilight: true)
    }
    
    /// Get the length of the day's daytime.
    func daytimeLength() -> TimeInterval {
        return calculateIntervalLength(altitude: -35.0 / 60.0, isTwilight: false)
    }
    
    /// Get the length of the day's civil twilight.
    func civilTwilightLength() -> TimeInterval {
        return calculateIntervalLength(altitude: -6.0, isTwilight: true)
    }
    
    /// Get the length of the day's nautical twilight.
    func nauticalTwilightLength() -> TimeInterval {
        return calculateIntervalLength(altitude: -12.0, isTwilight: true)
    }
    
    /// Get the length of the day's astronomical twilight.
    func astronomicalTwilightLength() -> TimeInterval {
        return calculateIntervalLength(altitude: -12.0, isTwilight: true)
    }
}
