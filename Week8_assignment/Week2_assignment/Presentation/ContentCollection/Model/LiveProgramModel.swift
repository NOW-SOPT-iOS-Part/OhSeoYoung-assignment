//
//  LiveProgramModel.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

struct LiveProgram {
    var rank: String
    var openDate: String
    var movieName: String
    var salesShare: String
    var image: UIImage?
}

extension LiveProgram {
    static func dummyData() -> [LiveProgram] {
        return [
            LiveProgram(rank: "1", openDate: "2024-04-24", movieName: "범죄도시4", salesShare: "79.1", image: nil),
            LiveProgram(rank: "2", openDate: "2024-04-10", movieName: "쿵푸팬더4", salesShare: "10.0", image: nil),
            LiveProgram(rank: "3", openDate: "2024-05-01", movieName: "포켓몬스터: 성도지방 이야기, 최종장", salesShare: "3.7", image: nil),
            LiveProgram(rank: "4", openDate: "2024-05-01", movieName: "스턴트맨", salesShare: "3.1", image: nil),
            LiveProgram(rank: "5", openDate: "2023-05-24", movieName: "남은 인생 10년", salesShare: "1.0", image: nil),
            LiveProgram(rank: "6", openDate: "2024-05-01", movieName: "꼬마참새 리차드: 신비한 보석 탐험대", salesShare: "0.6", image: nil)

        ]
    }
}

