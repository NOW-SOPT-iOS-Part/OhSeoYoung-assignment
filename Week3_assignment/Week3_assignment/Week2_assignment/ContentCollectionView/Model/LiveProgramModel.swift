//
//  LiveProgramModel.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

/// 라이브 프로그램 데이터 모델
struct LiveProgram {
    var ranking: String
    var title: String
    var channel: String
    var viewingRating: String
    var image: UIImage
}

extension LiveProgram {
    static func dummyData() -> [LiveProgram] {
        return [
            LiveProgram(ranking: "1", title: "보이즈 플래닛 12화", channel: "Mnet", viewingRating: "80.0", image: .yellow),
            LiveProgram(ranking: "2", title: "하트시그널 4화", channel: "Mnet", viewingRating: "24.1", image: .blue),
            LiveProgram(ranking: "3", title: "보이즈 플래닛 12화", channel: "Mnet", viewingRating: "80.0", image: .yellow),
            LiveProgram(ranking: "4", title: "하트시그널 4화", channel: "Mnet", viewingRating: "24.1", image: .blue),
            LiveProgram(ranking: "5", title: "보이즈 플래닛 12화", channel: "Mnet", viewingRating: "80.0", image: .yellow),
        ]
    }
}
