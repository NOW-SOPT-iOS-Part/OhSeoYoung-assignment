//
//  NetworkManager.swift
//  Week3_assignment
//
//  Created by 오서영 on 5/6/24.
//

import Foundation
import Moya
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
}

// MARK: - API Definition
enum BoxOfficeAPI {
    case fetchBoxOfficeData(date: String)
}

extension BoxOfficeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest")!
    }

    var path: String {
        switch self {
        case .fetchBoxOfficeData:
            return "/boxoffice/searchDailyBoxOfficeList.json"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .fetchBoxOfficeData(date):
            return .requestParameters(parameters: ["key": "b4ddbf38f567f468512099872d9cc672", "targetDt": date], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
}

// MARK: - NetworkManager with Moya
class NetworkManager {
    static let shared = NetworkManager()
    let provider = MoyaProvider<BoxOfficeAPI>()
    
    func fetchLivePrograms(completion: @escaping ([LiveProgram]?) -> Void) {
        // API 호출을 통해 데이터를 가져오는 코드 
        NetworkManager.shared.fetchBoxOfficeData { data, error in
            guard let data = data, error == nil else {
                print("API 에러 발생: \(error!)")
                completion(nil)
                return
            }

            // 데이터를 파싱하여 LiveProgram 배열을 생성
            let livePrograms = data.map { item -> LiveProgram in
                // 영화 이름으로 이미지를 찾습니다.
                let image = movieImageMapping[item.movieName]
                return LiveProgram(rank: item.rank,
                                   openDate: item.openDate,
                                   movieName: item.movieName,
                                   salesShare: item.salesShare,
                                   image: image)
            }

            completion(livePrograms)
        }
    }


    func fetchBoxOfficeData(completion: @escaping ([LiveProgram]?, Error?) -> Void) {
        provider.request(.fetchBoxOfficeData(date: "20240505")) { (result: Result<Moya.Response, MoyaError>) in
            switch result {
            case let .success(response):
                do {
                    let result = try JSONDecoder().decode(BoxOfficeResponse.self, from: response.data)
                    let livePrograms = result.boxOfficeResult.dailyBoxOfficeList.map {
                        LiveProgram(rank: $0.rank, openDate: $0.openDt, movieName: $0.movieNm, salesShare: $0.salesShare, image: UIImage(named: "defaultImage") ?? UIImage())
                    }
                    completion(livePrograms, nil)
                } catch let error {
                    completion(nil, error)
                }
            case let .failure(error):
                completion(nil, error)
            }
        }
    }
}
