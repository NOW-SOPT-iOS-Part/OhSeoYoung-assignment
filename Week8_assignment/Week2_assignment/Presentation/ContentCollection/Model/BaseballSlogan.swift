//
//  BaseballSlogan.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

struct BaseballSlogan {
    var image: UIImage
}

struct BaseballSloganDataGenerator {
    static func dummyData() -> [BaseballSlogan] {
        return [
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack),
            BaseballSlogan(image: .bearsSloganWhite),
            BaseballSlogan(image: .bearsSloganBlack)
        ]
    }
}
