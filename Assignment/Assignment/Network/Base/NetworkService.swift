//
//  NetworkService.swift
//  Assignment
//
//  Created by 오서영 on 6/29/24.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    let boxOfficeService: BoxOfficeService = BoxOfficeService()

}
