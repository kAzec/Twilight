//
//  Twilight+Description.swift
//  Twilight
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import Foundation
@testable import Twilight

extension Date {
    func description(in timezone: TimeZone) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = timezone
        return dateFormatter.string(from: self)
    }
}

extension Twilight {
    func description(in timezone: TimeZone) -> String {
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
                "Astronomical Twilight Length: %@\n"].joined(separator: ""),
                      "\(dateComponents.year!) \(dateComponents.month!) \(dateComponents.day!)",
                      self.sunrise().description(in: timezone), self.sunset().description(in: timezone),
                      self.civilTwilight().start.description(in: timezone), self.civilTwilight().end.description(in: timezone),
                      self.nauticalTwilight().start.description(in: timezone), self.nauticalTwilight().end.description(in: timezone),
                      self.astronomicalTwilight().start.description(in: timezone), self.astronomicalTwilight().end.description(in: timezone),
                      "\(self.daytimeLength() / secondsPerHour) h",
                      "\(self.civilTwilightLength() / secondsPerHour) h",
                      "\(self.nauticalTwilightLength() / secondsPerHour) h",
                      "\(self.astronomicalTwilightLength() / secondsPerHour) h"
        )
    }
}
