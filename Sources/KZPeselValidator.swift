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

    public let peselNumber: String
    private var result: Result?

    public init(pesel: String) {
        self.peselNumber = pesel
    }

    public func validate() -> Result {
        if let result = self.result { return result }

        var result: Result = .invalid
        defer {
            self.result = result
        }

        guard let pesel = KZPesel(pesel: peselNumber) else { return result }
        guard checkChecksum(pesel: pesel) else { return result }
        guard let peselParser = KZPeselParser(pesel: pesel) else { return result }

        result = .valid(peselInfo: peselParser.peselInfo)

        return result
    }

    private func checkChecksum(pesel: KZPesel) -> Bool {
        return validateWithMethodOne(pesel: pesel) &&
            validateWithMethodTwo(pesel: pesel)
    }

    private func validateWithMethodOne(pesel: KZPesel) -> Bool {
        let methodOneResult = zip(KZPeselSpec.validationMethodOneNumbersWeights, pesel.peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodOneResult % 10 == pesel.checkNumber
    }

    private func validateWithMethodTwo(pesel: KZPesel) -> Bool {
        let methodTwoResult = zip(KZPeselSpec.validationMethodTwoNumbersWeights, pesel.peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodTwoResult % 10 == 0
    }
}
