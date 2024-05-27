import Foundation
import Moya

protocol BoxOfficeServiceProtocol {
    func fetchBoxOfficeData(forDate date: String, completion: @escaping (NetworkResult<[DailyBoxOffice]>) -> Void)
}

// MARK: - BoxOfficeService for Network Calls
class BoxOfficeService: BaseService, BoxOfficeServiceProtocol {
    static let shared = BoxOfficeService()
    private let provider = MoyaProvider<BoxOfficeTargetType>()

    func fetchBoxOfficeData(forDate date: String, completion: @escaping (NetworkResult<[DailyBoxOffice]>) -> Void) {
        provider.request(.fetchBoxOfficeData(date: date)) { result in
            switch result {
            case .success(let response):
                let networkResult: NetworkResult<BoxOfficeResponse> = self.judgeStatus(statusCode: response.statusCode, data: response.data)
                switch networkResult {
                case .success(let boxOfficeResponse):
                    completion(.success(boxOfficeResponse.boxOfficeResult.dailyBoxOfficeList))
                case .requestErr, .decodedErr, .pathErr, .serverErr, .networkFail:
                    completion(.networkFail)
                }
            case .failure(let error):
                // Handle network failures
                print("Network error occurred: \(error.localizedDescription)")
                completion(.networkFail)
            }
        }
    }
}
