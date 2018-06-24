//
//  KZPeselParser.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

protocol KZPeselParserType {
    var peselNumber: String { get }
    var peselInfo: KZPeselInfo { get }
}

class KZPeselParser: KZPeselParserType {
    public var peselNumber: String {
        return pesel.pesel
    }

    public var peselInfo: KZPeselInfo {
        return KZPeselInfo(pesel: pesel.pesel,
                           birthDateComponents: birthDateComponents,
                           sex: sex)
    }

    private let pesel: KZPeselType
    private let birthYears: KZBirthYearsType
    private let birthYearsCollection: [KZBirthYearsType] = [
        KZBirthYears.eighteenHundreds,
        KZBirthYears.nineteenHundreds,
        KZBirthYears.twentyHundreds,
        KZBirthYears.twentyOneHundreds,
        KZBirthYears.twentyTwoHundreds
    ]

    private var sex: KZPeselSex {
        return pesel.sexNumber % 2 == 0 ? .female : .male
    }

    private var birthDateComponents: DateComponents {
        let day: Int = pesel.day
        let month: Int = pesel.monthWithYearsOffset - birthYears.monthOffset
        let year: Int = pesel.yearSufix + birthYears.base

        let dateComponents = DateComponents(year: year,
                                            month: month,
                                            day: day)

        return dateComponents
    }

    public init?(pesel: KZPeselType) {
        let maybeBirthYears = birthYearsCollection.first(where: {
            $0.monthWithOffsetRange.contains(pesel.monthWithYearsOffset)
        })

        guard let birthYears = maybeBirthYears else { return nil }

        self.pesel = pesel
        self.birthYears = birthYears
    }
}
