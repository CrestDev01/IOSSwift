//
//  RestApiService.swift
//  ZOOMiNLive
//
//  Created by Wolves on 11/22/22.
//  Copyright © 2022 Chris. All rights reserved.
//

import Foundation
import Alamofire

protocol Repository {
    func loginUser(param: [String: Any], method: HTTPMethod, complete: @escaping (Result<Resp<LoginModel>>) -> ())
    func registerUser(param: [String: Any], method : HTTPMethod, complete: @escaping (Result<Resp<RegisterModel>>) -> ())
    func addJob(param: [String: Any], token: String, method : HTTPMethod, complete: @escaping (Result<Resp<RegisterModel>>) -> ())
    func getUserProfile(token: String, method : HTTPMethod, complete: @escaping (Result<Resp<UserModel>>) -> ())

}

class RepositoryImpl: Repository {
    
    private let jsonHeaders: HTTPHeaders = ["Content-Type": "application/json"]
    
    func loginUser(param: [String: Any], method: HTTPMethod, complete: @escaping (Result<Resp<LoginModel>>) -> ()){
      
        AF.request(loginUserEndpoint,
                   method: method,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: jsonHeaders,
                   interceptor: nil)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Resp<LoginModel>.self) { response in
            self.safeApiCall(response: response, callback: complete)
        }
    }
    
    func registerUser(param: [String: Any], method: HTTPMethod, complete: @escaping (Result<Resp<RegisterModel>>) -> ()) {
        AF.request(registerUserEndpoint,
                   method: method,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: jsonHeaders,
                   interceptor: nil)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Resp<RegisterModel>.self) { response in
            self.safeApiCall(response: response, callback: complete)
        }
    }
    
    func addJob(param: [String: Any], token: String, method: HTTPMethod, complete: @escaping (Result<Resp<RegisterModel>>) -> ()) {
        AF.request(addJobEndpoint,
                   method: method,
                   parameters: param,
                   encoding: JSONEncoding.default,
                   headers: self.tokenHeaders(token),
                   interceptor: nil)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Resp<RegisterModel>.self) { response in
            self.safeApiCall(response: response, callback: complete)
        }
    }
    
    
    func getUserProfile( token: String, method: HTTPMethod, complete: @escaping (Result<Resp<UserModel>>) -> ()) {
        AF.request(getUserEndpoint,
                   method: method,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: self.tokenHeaders(token),
                   interceptor: nil)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Resp<UserModel>.self) { response in
            self.safeApiCall(response: response, callback: complete)
        }
    }
    
    private func safeApiCall<T>(response: AFDataResponse<T>, callback: @escaping (Result<T>) -> ()) {
        if let data = response.data {
            if let rawStringResp = String(bytes: data, encoding: .utf8) {
                print("Raw string response: \(rawStringResp)")
            }
        }
        switch (response.result) {
        case .success(let result):
            callback(.Success(result))
        case .failure(let error):
            
            var er: ErrorResponse? = nil
            
            if let data = response.data, let respRaw = response.response {
                do {
                    er = try JSONDecoder().decode(ErrorResponse.self, from: data)
                } catch let parseError {
                    if respRaw.statusCode == 401 {
                        print("authorization token expired!! \(respRaw.statusCode)")
                        return
                    }
                    print("Parsing failure of Error Response - \(parseError)")
                    callback(.GenericError(respRaw.statusCode, ApiError(isSuccess: false, message: "Something went wrong from server. 0x1004", status: respRaw.statusCode)))
                    return
                }
            }
            
            if error.isResponseSerializationError {
                // Parsing response failed
                print("Parsing failure of Response - \(error)")
                callback(.GenericError(1002, ApiError(isSuccess: false, message: "Something went wrong from server. 0x1002", reason: error, status: 0)))
            } else {
                if let respError = er, let respRaw = response.response {
                    if respRaw.statusCode == 401 {
                        print("authorization token expired!! \(respRaw.statusCode)")
                    
                        return
                    }
                    callback(.GenericError(respRaw.statusCode, ApiError(isSuccess: false, message: respError.message ?? "Something went wrong from server. 0x1003", status: respRaw.statusCode)))
                    return
                }
                if error.isSessionTaskError {
                    // Socket timeout : Network Issue
                    print("Connection error - \(error)")
                    callback(.NetworkError)
                } else {
                    print("Unkown error - \(error)")
                    callback(.GenericError(1001, ApiError(isSuccess: false, message: "Something went wrong from server. 0x1001", status: 0)))
                }
            }
           
        }
    }
//    
    private func tokenHeaders(_ token: String) -> HTTPHeaders {
        print("authtoken: \(token)")
        return ["Content-Type": "application/json",
                "Authorization": "\(token)","language": "en"]
    }
}
