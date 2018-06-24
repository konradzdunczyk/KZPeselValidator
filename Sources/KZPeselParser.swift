//
//  KZPeselParser.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public enum KZPeselParseResult {
    case success(peselInfo: KZPeselInfo)
    case peselInvalid(peselNumber: String)
}

public class KZPeselParser: KZPeselParserType {
    public var peselValidator: KZPeselValidatorType = KZPeselValidator()
    var birthYearsCollection: [KZBirthYearsType] = [
        KZBirthYears.eighteenHundreds,
        KZBirthYears.nineteenHundreds,
        KZBirthYears.twentyHundreds,
        KZBirthYears.twentyOneHundreds,
        KZBirthYears.twentyTwoHundreds
    ]

    public init() { }

    public func parse(peselNumber: String) -> KZPeselParseResult {
        guard let pesel = KZPesel(pesel: peselNumber),
              case KZPeselValidationResult.valid(_) = peselValidator.validate(pesel: pesel),
              let birthDateComponents = findBirthDateComponents(for: pesel) else {
            return .peselInvalid(peselNumber: peselNumber)
        }

        let sex: KZPeselSex = getSex(for: pesel)
        let peselInfo = KZPeselInfo(pesel: pesel.pesel,
                                    birthDateComponents: birthDateComponents,
                                    sex: sex)

        return .success(peselInfo: peselInfo)
    }

    private func getSex(for pesel: KZPeselType) -> KZPeselSex {
        return pesel.sexNumber % 2 == 0 ? .female : .male
    }

    private func findBirthDateComponents(for pesel: KZPeselType) -> DateComponents? {
        let maybeBirthYears = birthYearsCollection.first(where: {
            $0.monthWithOffsetRange.contains(pesel.monthWithYearsOffset)
        })
        guard let birthYears = maybeBirthYears else { return nil }

        let day: Int = pesel.day
        let month: Int = pesel.monthWithYearsOffset - birthYears.monthOffset
        let year: Int = pesel.yearSufix + birthYears.base

        return DateComponents(year: year,
                              month: month,
                              day: day)
    }
}
