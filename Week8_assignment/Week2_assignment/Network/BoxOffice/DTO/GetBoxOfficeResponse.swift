//
//  GetBoxOfficeResponse.swift
//  Week3_assignment
//
//  Created by 오서영 on 5/27/24.
//

import Foundation
import UIKit

// MARK: - BoxOfficeResponse Definition
struct BoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOffice]
}

struct DailyBoxOffice: Codable {
    let rank: String
    let openDt: String
    let movieNm: String
    let salesShare: String
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case rank, openDt, movieNm, salesShare, imageURL
    }
}


