//
//  KZPeselValidator.swift
//  KZPeselValidator
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public class KZPeselValidator {
    public enum Result {
        case valid(peselInfo: KZPeselInfo)
        case invalid
    }

    private enum BirthYears {
        case eighteenHundreds
        case nineteenHundreds
        case twentyHundreds
        case twentyOneHundreds
        case twentyTwoHundreds

        var monthOffset: Int {
            switch self {
            case .eighteenHundreds: return 80
            case .nineteenHundreds: return 0
            case .twentyHundreds: return 20
            case .twentyOneHundreds: return 40
            case .twentyTwoHundreds: return 60
            }
        }

        var monthRange: CountableClosedRange<Int> {
            return (monthOffset + 1...monthOffset + 12)
        }

        var base: Int {
            switch self {
            case .eighteenHundreds: return 1800
            case .nineteenHundreds: return 1900
            case .twentyHundreds: return 2000
            case .twentyOneHundreds: return 2100
            case .twentyTwoHundreds: return 2200
            }
        }

        static var allCases: [BirthYears] {
            return [
                .eighteenHundreds,
                .nineteenHundreds,
                .twentyHundreds,
                .twentyOneHundreds,
                .twentyTwoHundreds
            ]
        }

        static func getYears(for monthWithYearsOffset: Int) -> BirthYears {
            for years in BirthYears.allCases {
                if years.monthRange.contains(monthWithYearsOffset) {
                    return years
                }
            }

            fatalError()
        }
    }

    static let peselValidLength: Int = 11
    static let sexIndex: Int = 9
    static let magicNumbersOne: [Int] = [9, 7, 3, 1, 9, 7, 3, 1, 9, 7]
    static let magicNumbersTwo: [Int] = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3, 1]

    public let pesel: String
    private var result: Result?

    public init(pesel: String) {
        self.pesel = pesel
    }

    public func validate() -> Result {
        if let result = result { return result }

        let filteredPesel = pesel.filter({ Int(String($0)) != nil })
        guard filteredPesel.count == KZPeselValidator.peselValidLength else {
            self.result = .invalid
            return .invalid
        }

        let peselNumbers = filteredPesel.map({ return Int(String($0))! })

        guard checkChecksum(peselNumbers: peselNumbers) else {
            self.result = .invalid
            return .invalid
        }

        let sex = getSex(peselNumbers: peselNumbers)
        let birthDate = getBirthDate(peselNumbers: peselNumbers)
        let peselInfo = KZPeselInfo(pesel: pesel, birthDate: birthDate, sex: sex)

        self.result = .valid(peselInfo: peselInfo)
        return .valid(peselInfo: peselInfo)
    }

    private func getSex(peselNumbers: [Int]) -> KZPeselInfo.Sex {
        precondition(peselNumbers.count == KZPeselValidator.peselValidLength, "Wrong pesel length")

        return peselNumbers[KZPeselValidator.sexIndex] % 2 == 0 ? .female : .male
    }

    private func getBirthDate(peselNumbers: [Int]) -> Date {
        precondition(peselNumbers.count == KZPeselValidator.peselValidLength, "Wrong pesel length")

        let yearSufix: Int = peselNumbers[0] * 10 + peselNumbers[1]
        let monthWithYearsOffset: Int = peselNumbers[2] * 10 + peselNumbers[3]
        let day: Int = peselNumbers[4] * 10 + peselNumbers[5]
        let years = BirthYears.getYears(for: monthWithYearsOffset)
        let month: Int = monthWithYearsOffset - years.monthOffset
        let year: Int = yearSufix + years.base

        let dateComponents = DateComponents(calendar: Calendar.current,
                                            timeZone: TimeZone(abbreviation: "GMT+1"),
                                            year: year,
                                            month: month,
                                            day: day,
                                            hour: 0,
                                            minute: 0,
                                            second: 0)

        return dateComponents.date!
    }

    private func checkChecksum(peselNumbers: [Int]) -> Bool {
        precondition(peselNumbers.count == KZPeselValidator.peselValidLength, "Wrong pesel length")

        return validateWithMethodOne(peselNumbers: peselNumbers) &&
            validateWithMethodTwo(peselNumbers: peselNumbers)
    }

    private func validateWithMethodOne(peselNumbers: [Int]) -> Bool {
        precondition(peselNumbers.count == KZPeselValidator.peselValidLength, "Wrong pesel length")

        guard let checkNumber = peselNumbers.last else { return false }

        let methodOneResult = zip(KZPeselValidator.magicNumbersOne, peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodOneResult % 10 == checkNumber
    }

    private func validateWithMethodTwo(peselNumbers: [Int]) -> Bool {
        precondition(peselNumbers.count == KZPeselValidator.peselValidLength, "Wrong pesel length")

        let methodTwoResult = zip(KZPeselValidator.magicNumbersTwo, peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodTwoResult % 10 == 0
    }
}
