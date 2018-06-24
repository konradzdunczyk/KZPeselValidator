//
//  KZPeselParserTests.swift
//  KZPeselValidator
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import XCTest
import KZPeselValidator

class KZPeselParserTests: XCTestCase {
    let correctMalePesel: String = "76040106071"
    let correctFemalePesel: String = "76111117302"

    func testThatParserReturnPeselInvalidResultForIncorrectPesel() {
        let incorrectPesel = "7604010607"
        let sut = KZPeselParser()

        switch sut.parse(peselNumber: incorrectPesel) {
        case .success:
            XCTFail()
        case .peselInvalid(let peselNumber):
            XCTAssertEqual(peselNumber, incorrectPesel)
        }
    }

    func testThatParserReturnSuccessResultWithCorrectPeselForCorrectPesel() {
        let sut = KZPeselParser()

        switch sut.parse(peselNumber: correctMalePesel) {
        case .success(let peselInfo):
            XCTAssertEqual(peselInfo.pesel, correctMalePesel)
        case .peselInvalid:
            XCTFail()
        }
    }

    func testThatParserReturnSuccessResultWithCorrectSexInfoForCorrectFemalePesel() {
        let sut = KZPeselParser()

        switch sut.parse(peselNumber: correctFemalePesel) {
        case .success(let peselInfo):
            XCTAssertEqual(peselInfo.sex, KZPeselSex.female)
        case .peselInvalid:
            XCTFail()
        }
    }

    func testThatParserReturnSuccessResultWithCorrectSexInfoForCorrectMalePesel() {
        let sut = KZPeselParser()

        switch sut.parse(peselNumber: correctMalePesel) {
        case .success(let peselInfo):
            XCTAssertEqual(peselInfo.sex, KZPeselSex.male)
        case .peselInvalid:
            XCTFail()
        }
    }

    func testThatParserReturnSuccessResultWithCorrectDateComponentsForPeselFromEighteenHundreds() {
        let pesel = "01841216038"
        let expectedResult = DateComponents(year: 1801,
                                            month: 04,
                                            day: 12)

        dateComponentsTest(pesel: pesel, expectedResult: expectedResult)
    }

    func testThatParserReturnSuccessResultWithCorrectDateComponentsForPeselFromNineteenHundreds() {
        let pesel = "01051201983"
        let expectedResult = DateComponents(year: 1901,
                                            month: 05,
                                            day: 12)

        dateComponentsTest(pesel: pesel, expectedResult: expectedResult)
    }

    func testThatParserReturnSuccessResultWithCorrectDateComponentsForPeselFromTwentyHundreds() {
        let pesel = "01250512275"
        let expectedResult = DateComponents(year: 2001,
                                            month: 05,
                                            day: 05)

        dateComponentsTest(pesel: pesel, expectedResult: expectedResult)
    }

    func testThatParserReturnSuccessResultWithCorrectDateComponentsForPeselFromTwentyOneHundreds() {
        let pesel = "01450502384"
        let expectedResult = DateComponents(year: 2101,
                                            month: 05,
                                            day: 05)

        dateComponentsTest(pesel: pesel, expectedResult: expectedResult)
    }

    func testThatParserReturnSuccessResultWithCorrectDateComponentsForPeselFromTwentyTwoHundreds() {
        let pesel = "01650504115"
        let expectedResult = DateComponents(year: 2201,
                                            month: 05,
                                            day: 05)

        dateComponentsTest(pesel: pesel, expectedResult: expectedResult)
    }

    private func dateComponentsTest(pesel: String, expectedResult: DateComponents) {
        let sut = KZPeselParser()

        switch sut.parse(peselNumber: pesel) {
        case .success(let peselInfo):
            XCTAssertEqual(peselInfo.birthDateComponents, expectedResult)
        case .peselInvalid:
            XCTFail()
        }
    }
}
