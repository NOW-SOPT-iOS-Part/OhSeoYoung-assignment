//
//  BaseTargetType.swift
//  Week3_assignment
//
//  Created by 오서영 on 5/27/24.
//

import Foundation

import Moya

protocol BaseTargetType: TargetType {
    var utilPath: String { get }
    var method: Moya.Method { get }
}

extension BaseTargetType {
    
    var baseURL: URL {
        guard let urlString = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.baseURL) as? String,
              let url = URL(string: urlString) else {
            fatalError("🚨BASE_URL을 찾을 수 없습니다🚨")
        }
        return url
    }
    
    var headers: [String : String]? {
        let headers = ["Content-Type" : "application/json"]
        return headers
    }
    
}
