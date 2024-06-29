import Foundation
import Moya

// MARK: - BoxOfficeTargetType for defining API endpoints
enum BoxOfficeTargetType {
    case fetchBoxOfficeData(date: String)
}

extension BoxOfficeTargetType: TargetType {
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

    var task: Task {
        switch self {
        case let .fetchBoxOfficeData(date):
            return .requestParameters(parameters: ["key": apiKey, "targetDt": date], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}

