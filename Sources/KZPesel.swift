//
//  KZPesel.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public struct KZPesel: KZPeselType {
    public let pesel: String
    public let peselNumbers: [Int]

    init?(pesel: String) {
        guard pesel.count == KZPeselSpec.peselValidLength else {
            return nil
        }

        let peselNumbers: [Int] = pesel.compactMap({ Int(String($0)) })

        guard peselNumbers.count == KZPeselSpec.peselValidLength else {
            return nil
        }

        self.pesel = pesel
        self.peselNumbers = peselNumbers
    }

    public var checkNumber: Int {
        return peselNumbers[10]
    }

    public var yearSufix: Int {
        return peselNumbers[0] * 10 + peselNumbers[1]
    }

    public var monthWithYearsOffset: Int {
        return peselNumbers[2] * 10 + peselNumbers[3]
    }

    public var day: Int {
        return peselNumbers[4] * 10 + peselNumbers[5]
    }

    public var sexNumber: Int {
        return peselNumbers[9]
    }
}
