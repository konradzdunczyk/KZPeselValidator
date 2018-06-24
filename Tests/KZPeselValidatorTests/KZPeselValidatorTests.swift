//
//  KZPeselValidatorTests.swift
//  KZPeselValidator
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation
import XCTest
import KZPeselValidator

class KZPeselValidatorTests: XCTestCase {
    let correctFemalePesel: String = "76111117302"

    func testThatValidatorReturnInvalidResultForPeselWithWrongCheckNumber() {
        let incorrectPesel = "76111117301"
        let sut = KZPeselValidator()

        switch sut.validate(peselNumber: incorrectPesel) {
        case .valid:
            XCTFail()
        case .invalid(let peselNumber):
            XCTAssertEqual(peselNumber, incorrectPesel)
        }
    }

    func testThatValidatorReturnValidResultForCorrectPesel() {
        let sut = KZPeselValidator()

        switch sut.validate(peselNumber: correctFemalePesel) {
        case .valid(let peselNumber):
            XCTAssertEqual(peselNumber, correctFemalePesel)
        case .invalid:
            XCTFail()
        }
    }
}
