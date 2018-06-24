//
//  KZPeselSpec.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

enum KZPeselSpec {
    static let peselValidLength: Int = 11
    static let validationMethodOneNumbersWeights: [Int] = [9, 7, 3, 1, 9, 7, 3, 1, 9, 7]
    static let validationMethodTwoNumbersWeights: [Int] = [1, 3, 7, 9, 1, 3, 7, 9, 1, 3, 1]
}
