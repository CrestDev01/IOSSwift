//
//  RestApiRequest.swift
//  ZOOMiNLive
//
//  Created by Wolves on 11/22/22.
//  Copyright © 2022 Chris. All rights reserved.
//

import Foundation

struct AuthenticateRequest: Decodable {
    let userName: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "email"
        case password
    }
}

struct ForgotPasswordRequest: Decodable {
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "email"
    }
}
