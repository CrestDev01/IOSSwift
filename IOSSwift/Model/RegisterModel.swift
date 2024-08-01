//
//  RegisterModel.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation
struct RegisterModel : Codable {
  
    let token : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
    }

}
