//
//  AuthResponse.swift
//  IOSSwift
//
//  Created by CrestAdmin on 26/07/24.
//

import Foundation

struct LoginModel : Codable {
    let token : String?
    let docStatus : Int?
    let user_verified : Bool?
    let country_code : String?
    let phone : String?
    let dob : String?
    let language : String?

    enum CodingKeys: String, CodingKey {

        case token = "token"
        case docStatus = "docStatus"
        case user_verified = "user_verified"
        case country_code = "country_code"
        case phone = "phone"
        case dob = "dob"
        case language = "language"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        token = try values.decodeIfPresent(String.self, forKey: .token)
        docStatus = try values.decodeIfPresent(Int.self, forKey: .docStatus)
        user_verified = try values.decodeIfPresent(Bool.self, forKey: .user_verified)
        country_code = try values.decodeIfPresent(String.self, forKey: .country_code)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        language = try values.decodeIfPresent(String.self, forKey: .language)
    }

}
