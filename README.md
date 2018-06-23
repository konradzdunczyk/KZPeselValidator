# KZPeselValidator
> Validator for Polish national identification number PESEL

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

KZPeselValidator validate PESEL with two methods:
Method one: (9×a + 7×b + 3×c + 1×d + 9×e + 7×f + 3×g + 1×h + 9×i + 7×j) % 10 == check number
Method two: (1×a + 3×b + 7×c + 9×d + 1×e + 3×f + 7×g + 9×h + 1×i + 3×j + 1×k) % 10 == 0

Letters 'a' to 'k' are subsequent numbers of PESEL number.

![](header.png)

## Features

- [x] Validate PESEL number
- [x] Get sex of PESEL owner
- [x] Get birthdate of PESEL owner

## Validation details

KZPeselValidator validate PESEL with two methods simultaneously:
Method one: (9×a + 7×b + 3×c + 1×d + 9×e + 7×f + 3×g + 1×h + 9×i + 7×j) % 10 == check number (last digit of PESEL)
Method two: (1×a + 3×b + 7×c + 9×d + 1×e + 3×f + 7×g + 9×h + 1×i + 3×j + 1×k) % 10 == 0

Letters 'a' to 'k' are subsequent numbers of PESEL number.

## Requirements

- iOS 8.0+
- Xcode 7.3
- Swift 3.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `KZPeselValidator` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'KZPeselValidator'
```

#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/KZPeselValidator.framework` to an iOS project.

```
github "konradzdunczyk/KZPeselValidator"
```

#### Manually
1. Download and drop Source folder in your project.  
2. Congratulations!  

## Usage example

```swift
import KZPeselValidator

let validator = KZPeselValidator(pesel: "76040117112")
let validationResult = validator.validate()

switch validationResult {
case .valid(let peselInfo):
  print("Pesel \(peselInfo.pesel) is valid")
  print("Birthdate: \(peselInfo.birthDate)")
  print("Sex: ", terminator: "")

  switch peselInfo.sex {
  case .male:
    print("male")
  case .female:
    print("female")
  }
case .invalid:
  print("Pesel \(validator.pesel) is invalid")
}
```

## Contribute

I would love you for the contribution to **KZPeselValidator**, check the ``LICENSE`` file for more info.

## Meta

Konrad Zdunczyk – konrad.zdunczyk@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/konradzdunczyk/KZPeselValidator](https://github.com/konradzdunczyk/KZPeselValidator)

## Attributions

I've used [SwiftPlate](https://github.com/JohnSundell/SwiftPlate) to generate xcodeproj compatible with CocoaPods and Carthage.
