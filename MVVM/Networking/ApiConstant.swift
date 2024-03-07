//
//  ApiConstant.swift
//  MVVM
//
//  Created by Ngoc H. Le on 06/03/2024.
//

import Foundation



enum ApiContant {
    case login(LoginParam)
    case register
    case getUsers(GetUserParam)
}

extension ApiContant {
    public var serverUrl: String {
        get {
            return "https://randomuser.me/api"
        }
    }
    private var path: String {
        switch self {
        case .login:
            return "/login"
        case .register:
            return "/register"
        case .getUsers:
            return "/users"
        }
    }
    
    private var params: [String: Any] {
        switch self {
        case let .login(params):
            return ["userName": params.userName, "password": params.password]
        case .register:
            return [:]
        case let .getUsers(params):
            return ["roomId": params.roomId, "pageIndex": params.pageIndex, "pageSize": params.pageSize]
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}
