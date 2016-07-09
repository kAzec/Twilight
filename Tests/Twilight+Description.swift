//
//  Twilight+Description.swift
//  Twilight
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation
@testable import Twilight

extension NSDate {
    func description(in timezone: NSTimeZone) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = timezone
        return dateFormatter.stringFromDate(self)
    }
}

extension Twilight {
    func description(in timezone: NSTimeZone) -> String {
        return String(format:
            ["Date: %@\n",
                "Sunrise: %@\n",
                "Sunset: %@\n",
                "Civil Twilight Start: %@\n",
                "Civil Twilight End: %@\n",
                "Nautical Twilight Start: %@\n",
                "Nautical Twilight End: %@\n",
                "Astronomical Twilight Start: %@\n",
                "Astronomical Twilight End: %@\n",
                "Daytime Length: %@\n",
                "Nautical Twilight Length: %@\n",
                "Civil Twilight Length: %@\n",
                "Astronomical Twilight Length: %@\n"].joinWithSeparator(""),
                      "\(dateComponents.year) \(dateComponents.month) \(dateComponents.day)",
                      self.sunrise().description(in: timezone), self.sunset().description(in: timezone),
                      self.twilight(.civil).start.description(in: timezone), self.twilight(.civil).end.description(in: timezone),
                      self.twilight(.nautical).start.description(in: timezone), self.twilight(.nautical).end.description(in: timezone),
                      self.twilight(.astronomical).start.description(in: timezone), self.twilight(.astronomical).end.description(in: timezone),
                      "\(self.daytimeLength() / secondsPerHour) h",
                      "\(self.twilightLength(.civil) / secondsPerHour) h",
                      "\(self.twilightLength(.nautical) / secondsPerHour) h",
                      "\(self.twilightLength(.astronomical) / secondsPerHour) h"
        )
    }
}