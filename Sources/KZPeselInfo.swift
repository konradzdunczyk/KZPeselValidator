//
//  KZPeselInfo.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public struct KZPeselInfo {
    public enum Sex {
        case male
        case female
    }

    let pesel: String
    let birthDate: Date
    let sex: Sex
}
