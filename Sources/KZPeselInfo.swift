//
//  KZPeselInfo.swift
//  KZPeselValidator-iOS
//
//  Created by Konrad Zdunczyk on 24/06/2018.
//  Copyright © 2018 KZPeselValidator. All rights reserved.
//

import Foundation

public struct KZPeselInfo {
    public let pesel: String
    public let birthDateComponents: DateComponents
    public let sex: KZPeselSex
}
