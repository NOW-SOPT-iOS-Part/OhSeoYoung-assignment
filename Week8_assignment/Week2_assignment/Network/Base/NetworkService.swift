//
//  NetworkService.swift
//  Week3_assignment
//
//  Created by 오서영 on 5/27/24.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
//    let transferService: TransferService = TransferService()
    let boxOfficeService: BoxOfficeService = BoxOfficeService()

}
