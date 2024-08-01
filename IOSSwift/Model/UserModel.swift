//
//  UserModel.swift
//  BasicSwiftDemo
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation


struct UserModel : Codable {
    let userId : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let country_code : String?
    let phone : String?
    let image : String?
    let createdAt : String?
    
    
    enum CodingKeys: String, CodingKey {

        case userId = "UserId"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case country_code = "country_code"
        case phone = "phone"
        case image = "image"
        case createdAt = "createdAt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userId = try values.decodeIfPresent(Int.self, forKey: .userId)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)

    }

}

