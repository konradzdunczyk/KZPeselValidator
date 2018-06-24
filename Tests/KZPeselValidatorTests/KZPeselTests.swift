//
//  KZPeselTests.swift
//  KZPeselValidator
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import XCTest
import KZPeselValidator

class KZPeselTests: XCTestCase {
    let correctFemalePesel: String = "76111117302"

    func testThatPeselInitReturnNilForEmptyPesel() {
        let sut = KZPesel(pesel: "")

        XCTAssertNil(sut)
    }

    func testThatPeselInitReturnNilForTooShortPesel() {
        let sut = KZPesel(pesel: "7604011711")

        XCTAssertNil(sut)
    }

    func testThatPeselInitReturnNilForTooLongPesel() {
        let sut = KZPesel(pesel: "760401171120")

        XCTAssertNil(sut)
    }

    func testThatPeselInitReturnNilForPeselWithWrongCharacters() {
        let sut = KZPesel(pesel: "76040117i12")

        XCTAssertNil(sut)
    }

    func testThatPeselInitReturnNilForPeselWithWrongCharactersBetween() {
        let sut = KZPesel(pesel: "7x6x0x4x0x1x1x7x1x1x2")

        XCTAssertNil(sut)
    }

    func testThatPeselInitReturnInstanceForCorrectLengthPeselAndCharacterSet() {
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertNotNil(sut)
    }

    func testThatPeselGiveCorrectSexNumber() {
        let expectedResult: Int = 0
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertEqual(sut!.sexNumber, expectedResult)
    }

    func testThatPeselGiveCorrectDay() {
        let expectedResult: Int = 11
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertEqual(sut!.day, expectedResult)
    }

    func testThatPeselGiveCorrectMonthWithYearsOffset() {
        let expectedResult: Int = 11
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertEqual(sut!.monthWithYearsOffset, expectedResult)
    }

    func testThatPeselGiveCorrectYearSufix() {
        let expectedResult: Int = 76
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertEqual(sut!.yearSufix, expectedResult)
    }

    func testThatPeselGiveCorrectCheckNumber() {
        let expectedResult: Int = 2
        let sut = KZPesel(pesel: correctFemalePesel)

        XCTAssertEqual(sut!.checkNumber, expectedResult)
    }
}
