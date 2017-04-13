//
//  TwilightTests.swift
//  TwilightTests
//
//  Created by 锋炜 刘 on 16/7/10.
//  Copyright © 2016年 kAzec. All rights reserved.
//

import XCTest
import Twilight

class TwilightTests: XCTestCase {
    let cities: [String:(latitude: Double, longtitude: Double, timezone: String)] = [
        "Madrid"    :(latitude: 40.4165    , longtitude: -3.70256      , timezone: "Europe/Madrid"),
        "Beijing"   :(latitude: 39.9075    , longtitude: 116.39723     , timezone: "Asia/Shanghai"),
        "Cupertino" :(latitude: 37.3229978 , longtitude: -122.0321823  , timezone: "America/Los_Angeles"),
        "New York"  :(latitude: 40.7127837 , longtitude: -74.0059413   , timezone: "America/New_York"),
        "Tokyo"     :(latitude: 35.6894875 , longtitude: 139.6917064   , timezone: "Asia/Tokyo"),
        "Sydney"    :(latitude: -33.8674869, longtitude: 151.2069902   , timezone: "Australia/Sydney"),
    ]
    
    func testOutput() {
        let now = Date()
        cities.forEach { name, info in
            print("------City: \(name)------")
            let twilight = Twilight(date: now, longtitude: info.longtitude, latitude: info.latitude)
            print(twilight.description(in: TimeZone(identifier: info.timezone)!))
        }
    }
}
