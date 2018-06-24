//
//  KZPeselTypes.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public enum KZPeselSex {
    case male
    case female
}

public enum KZPeselValidationResult {
    case valid(peselNumber: String)
    case invalid(peselNumber: String)
}

public protocol KZPeselValidatorType {
    func validate(peselNumber: String) -> KZPeselValidationResult
    func validate(pesel: KZPeselType) -> KZPeselValidationResult
}

public protocol KZPeselParserType {
    func parse(peselNumber: String) -> KZPeselParseResult
}

public protocol KZPeselType {
    var pesel: String { get }
    var peselNumbers: [Int] { get }
    var checkNumber: Int { get }
    var yearSufix: Int { get }
    var monthWithYearsOffset: Int { get }
    var day: Int { get }
    var sexNumber: Int { get }
}

protocol KZBirthYearsType {
    var monthOffset: Int { get }
    var monthWithOffsetRange: CountableClosedRange<Int> { get }
    var base: Int { get }
}
