//
//  LiveProgramModel.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

/// 라이브 프로그램 데이터 모델
struct LiveProgram {
    var rank: String
    var openDate: String
    var movieName: String
    var salesShare: String
    var image: UIImage
}

extension LiveProgram {
    static func dummyData() -> [LiveProgram] {
        return [

        ]
    }
}
