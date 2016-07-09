//
//  Twilight.swift
//  Twilight
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation
import CSunriset

let secondsPerHour: NSTimeInterval = 3600

public final class Twilight {
    public enum Type {
        case civil, nautical, astronomical
    }
    
    public typealias Interval = (start: NSDate?, end: NSDate?)
    
    let calendar: NSCalendar
    let UTCTimezone: NSTimeZone

    let dateComponents: NSDateComponents
    let longtitude: Double
    let latitude: Double
    
    var daytime: Interval
    var civilTwilight: Interval
    var nauticalTwilight: Interval
    var astronomicalTwilight: Interval
    
    var _daytimeLength: NSTimeInterval!
    var _civilTwilightLength: NSTimeInterval!
    var _nauticalTwilightLength: NSTimeInterval!
    var _astronomicalTwilightLength: NSTimeInterval!
    
    /**
     Create Twilight object using specified arguments.
     
     - parameter date:       A date in the day to calculate sunrise/sunset, etc.
     - parameter timezone:   The timezone the date given is in. It's used to extract the year/month/day of the given date.
     - parameter longtitude: The longtitude of the location.
     - parameter latitude:   The latitude of the location.
     
     - returns: A Twilight object the values of which are lazily evaluated.
     */
    public init(date: NSDate, timezone: NSTimeZone = NSTimeZone.systemTimeZone(), longtitude: Double, latitude: Double) {
        self.calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        self.UTCTimezone = NSTimeZone(abbreviation: "UTC")!

        self.calendar.timeZone = timezone
        self.dateComponents = calendar.components([.Year, .Month, .Day], fromDate: date)
        self.calendar.timeZone = UTCTimezone
        self.longtitude = longtitude
        self.latitude = latitude
    }
}

extension Twilight {
    func calculateInterval(altitude altitude: Double, isTwilight: Bool) -> Interval {
        let year = Int32(dateComponents.year)
        let month = Int32(dateComponents.month)
        let day = Int32(dateComponents.day)
        
        var startOffset: Double = 0
        var endOffset: Double = 0
        sunriset(year, month, day, longtitude, latitude, altitude, isTwilight ? 0 : 1, &startOffset, &endOffset)
        
        let start = calendar.dateFromComponents(dateComponents)!.dateByAddingTimeInterval(startOffset * secondsPerHour)
        let end = calendar.dateFromComponents(dateComponents)!.dateByAddingTimeInterval(endOffset * secondsPerHour)
        return (start, end)
    }
    
    func calculateDaytimeIfNeeded() {
        guard daytime.start == nil else { return }
        daytime = calculateInterval(altitude: -35.0 / 60.0, isTwilight: false)
    }
    
    func calculateCivilTwilightIfNeeded() {
        guard civilTwilight.start == nil else { return }
        civilTwilight = calculateInterval(altitude: -6.0, isTwilight: true)
    }
    
    func calculateNauticalTwilightIfNeeded() {
        guard nauticalTwilight.start == nil else { return }
        nauticalTwilight = calculateInterval(altitude: -12.0, isTwilight: true)
    }
    
    func calculateAstronomicalTwilightIfNeeded() {
        guard astronomicalTwilight.start == nil else { return }
        astronomicalTwilight = calculateInterval(altitude: -12.0, isTwilight: true)
    }
    
    func calculateIntervalLength(altitude altitude: Double, isTwilight: Bool) -> NSTimeInterval {
        let year = Int32(dateComponents.year)
        let month = Int32(dateComponents.month)
        let day = Int32(dateComponents.day)
        
        return daylen(year, month, day, longtitude, latitude, altitude, isTwilight ? 0 : 1) * secondsPerHour
    }
    
    func calculateDaytimeLength() -> NSTimeInterval {
        return calculateIntervalLength(altitude: -35.0 / 60.0, isTwilight: false)
    }
    
    func calculateCivilTwilightLength() -> NSTimeInterval {
        return calculateIntervalLength(altitude: -6.0, isTwilight: true)
    }
    
    func calculateNauticalTwilightLength() -> NSTimeInterval {
        return calculateIntervalLength(altitude: -12.0, isTwilight: true)
    }
    
    func calculateAstronomicalTwilightLength() -> NSTimeInterval {
        return calculateIntervalLength(altitude: -12.0, isTwilight: true)
    }
    
    func unwrap(interval: Interval) -> (start: NSDate, end: NSDate) {
        return (interval.start!, interval.end!)
    }
}

public extension Twilight {
    /**
     Get sunrise time.
     
     - returns: Sunrise time.
     */
    func sunrise() -> NSDate {
        calculateDaytimeIfNeeded()
        return daytime.start!
    }
    
    /**
     Get sunset time.
     
     - returns: Sunset time.
     */
    func sunset() -> NSDate {
        calculateDaytimeIfNeeded()
        return daytime.end!
    }
    
    /**
     Get twilight start/end time for specified twilight type.
     
     **Note**: For more information for twilight types, please refer to [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)
     
     - parameter type: Twilight types: .civil, .nautical, .astronomical
     
     - returns: start/end time for specified twilight type.
     */
    func twilight(type: Type) -> (start: NSDate, end: NSDate) {
        switch type {
        case .civil:
            calculateCivilTwilightIfNeeded()
            return unwrap(civilTwilight)
        case .nautical:
            calculateNauticalTwilightIfNeeded()
            return unwrap(nauticalTwilight)
        case .astronomical:
            calculateAstronomicalTwilightIfNeeded()
            return unwrap(astronomicalTwilight)
        }
    }
    
    /**
     Get daytime length in seconds.
     
     - returns: Daytime length in seconds.
     */
    func daytimeLength() -> NSTimeInterval {
        if _daytimeLength == nil {
            _daytimeLength = calculateDaytimeLength()
        }
        return _daytimeLength!
    }
    
    /**
     Get twilight length for specified twilight type.
     
     **Note**: For more information for twilight types, please refer to [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)
     
     - parameter type: Twilight types: .civil, .nautical, .astronomical
     
     - returns: Length of specified twilight type in seconds.
     */
    func twilightLength(type: Type) -> NSTimeInterval {
        switch type {
        case .civil:
            if _civilTwilightLength == nil {
                _civilTwilightLength = calculateCivilTwilightLength()
            }
            return _civilTwilightLength!
        case .nautical:
            if _nauticalTwilightLength == nil {
                _nauticalTwilightLength = calculateNauticalTwilightLength()
            }
            return _nauticalTwilightLength!
        case .astronomical:
            if _astronomicalTwilightLength == nil {
                _astronomicalTwilightLength = calculateAstronomicalTwilightLength()
            }
            return _astronomicalTwilightLength!
        }
    }
}