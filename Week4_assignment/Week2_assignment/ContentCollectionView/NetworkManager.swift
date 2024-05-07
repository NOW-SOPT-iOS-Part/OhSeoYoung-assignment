//
//  NetworkManager.swift
//  Week3_assignment
//
//  Created by 오서영 on 5/6/24.
//

import Foundation
import UIKit

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
}

class NetworkManager {
    static let shared = NetworkManager()

    func fetchBoxOfficeData(completion: @escaping ([LiveProgram]?, Error?) -> Void) {
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=b4ddbf38f567f468512099872d9cc672&targetDt=20240505"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            // 콘솔에 데이터 출력
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("API 응답 데이터: \(jsonString)")
//            }

            do {
                let result = try JSONDecoder().decode(BoxOfficeResponse.self, from: data)
                let livePrograms = result.boxOfficeResult.dailyBoxOfficeList.map {
                    LiveProgram(rank: $0.rank, openDate: $0.openDt, movieName: $0.movieNm, salesShare: $0.salesShare, image: UIImage(named: "defaultImage") ?? UIImage())

                }
                
                completion(livePrograms, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
