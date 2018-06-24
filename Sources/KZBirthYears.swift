//
//  KZBirthYears.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

struct KZBirthYears: KZBirthYearsType {
    let monthOffset: Int
    let base: Int

    var monthWithOffsetRange: CountableClosedRange<Int> {
        return (monthOffset + 1...monthOffset + 12)
    }
}

extension KZBirthYears {
    static var eighteenHundreds: KZBirthYears {
        return KZBirthYears(monthOffset: 80, base: 1800)
    }

    static var nineteenHundreds: KZBirthYears {
        return KZBirthYears(monthOffset: 0, base: 1900)
    }

    static var twentyHundreds: KZBirthYears {
        return KZBirthYears(monthOffset: 20, base: 2000)
    }

    static var twentyOneHundreds: KZBirthYears {
        return KZBirthYears(monthOffset: 40, base: 2100)
    }

    static var twentyTwoHundreds: KZBirthYears {
        return KZBirthYears(monthOffset: 60, base: 2200)
    }
}
