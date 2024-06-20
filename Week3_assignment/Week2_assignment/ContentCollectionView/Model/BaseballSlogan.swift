//
//  BaseballSlogan.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

/// 야구 슬로건 데이터 모델
struct BaseballSlogan {
    var image: UIImage
}

extension BaseballSlogan {
    static func dummyData() -> [BaseballSlogan] {
        return [
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack),
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack)
        ]
    }
}
