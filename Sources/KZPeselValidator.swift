//
//  KZPeselValidator.swift
//  KZPeselValidator
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public class KZPeselValidator: KZPeselValidatorType {
    public init() { }

    public func validate(peselNumber: String) -> KZPeselValidationResult {
        guard let pesel = KZPesel(pesel: peselNumber) else {
            return .invalid(peselNumber: peselNumber)
        }

        return validate(pesel: pesel)
    }

    public func validate(pesel: KZPeselType) -> KZPeselValidationResult {
        guard checkChecksum(pesel: pesel) else { return .invalid(peselNumber: pesel.pesel) }

        return .valid(peselNumber: pesel.pesel)
    }

    private func checkChecksum(pesel: KZPeselType) -> Bool {
        return validateWithMethodOne(pesel: pesel) &&
            validateWithMethodTwo(pesel: pesel)
    }

    private func validateWithMethodOne(pesel: KZPeselType) -> Bool {
        let methodOneResult = zip(KZPeselSpec.validationMethodOneNumbersWeights, pesel.peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodOneResult != 0 && methodOneResult % 10 == pesel.checkNumber
    }

    private func validateWithMethodTwo(pesel: KZPeselType) -> Bool {
        let methodTwoResult = zip(KZPeselSpec.validationMethodTwoNumbersWeights, pesel.peselNumbers)
            .map({ $0 * $1 })
            .reduce(0, +)

        return methodTwoResult != 0 && methodTwoResult % 10 == 0
    }
}
