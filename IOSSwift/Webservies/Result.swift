//
//  Result.swift
//  ZOOMiNLive
//
//  Created by Wolves on 11/22/22.
//  Copyright © 2022 Chris. All rights reserved.
//

import Foundation

enum Result<T> {
    case Success(T)
    case GenericError(Int, ApiError)
    case NetworkError
}
