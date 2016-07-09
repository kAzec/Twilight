# Twilight

![Platforms](https://img.shields.io/badge/platforms-ios%20%7C%20osx%20%7C%20watchos%20%7C%20tvos-lightgrey.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](#carthage)
![Swift version](https://img.shields.io/badge/swift-2.2-orange.svg)

Twilight is a simple framework that calculates Sunrise, Sunset, and Twilight time based on the user's current location and time zone. 
This framework is based on [sunriset.c](http://stjarnhimlen.se/comp/sunriset.c) created by [Paul Schlyter](http://stjarnhimlen.se/english.html) and inspired by [erndev](https://github.com/erndev)'s [EDSunriseSet](https://github.com/erndev/EDSunriseSet).

## Getting Started

1. `import Twilight`.

2. Create a Twilight object and access values.

```swift
let now = NSDate()
let sunrise = Twilight(date: now, longtitude: longtitude, latitude: latitude).sunrise()
```

You can run the Test to test it's functionality.

## Supported methods

| Method                                                          | Documentation                                            |
|-----------------------------------------------------------------|----------------------------------------------------------|
| `sunrise() -> NSDate`                                           | Get sunrise time.                                        |
| `sunset()-> NSDate`                                             | Get sunset time.                                         |
| `twilight(type: Twilight.Type) -> (start: NSDate, end: NSDate)` | Get twilight start/end time for specified twilight type. |
| `daytimeLength() -> NSTimeInterval`                             | Get daytime length in seconds.                           |
| `twilightLength(type: Twilight.Type) -> NSTimeInterval`         | Get twilight length for specified twilight type.         |

> Twilight types: .civil, .nautical, .astronomical. For more information, please refer to [Twilight on Wikipedia](https://en.wikipedia.org/wiki/Twilight#Definitions)

## Installation
### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Log into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "kAzec/Twilight"
```

## License

Copyright (c) 2016 and kAzec

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


