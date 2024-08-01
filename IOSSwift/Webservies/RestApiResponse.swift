//
//  RestApiResponse.swift
//  ZOOMiNLive
//
//  Created by Wolves on 11/22/22.
//  Copyright © 2022 Chris. All rights reserved.
//

import Foundation

struct ApiError {
    let isSuccess: Bool
    let status: Int?
    let message: String
    let reason: Error?
    
    init(isSuccess: Bool, message: String, reason: Error? = nil, status: Int?) {
        self.isSuccess = isSuccess
        self.message = message
        self.reason = reason
        self.status = status
    }
}

struct ErrorResponse: Decodable {
    let status: Int?
    let message: String?
    //let data: [String: String]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        //case data = "Data"
    }
}

struct Nothing: Decodable {    
}

struct Resp<R: Decodable>: Decodable {
    let status: Int?
    let message: String?
    let data: R?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case message = "message"
        case data = "data"
    }
    
    func isValid() -> Bool {
        return status == 200 && data != nil
    }
}

