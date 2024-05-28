
import UIKit

/// 프로그램 포스터 데이터 모델
struct Poster {
    var name: String
    var image: UIImage
}

extension Poster {
    static func dummyData() -> [Poster] {
        return [
            Poster(name: "시그널", image: .signalPoster),
            Poster(name: "해리포터", image: .harrypotterPoster),
            Poster(name: "반지의 제왕", image: .ringPoster),
            Poster(name: "스즈메의 문단속", image: .doorPoster),
            Poster(name: "시그널", image: .signalPoster)
        ]
    }
}
