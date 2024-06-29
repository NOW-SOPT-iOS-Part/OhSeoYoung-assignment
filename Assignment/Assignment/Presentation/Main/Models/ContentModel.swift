//
//  ContentModel.swift
//  Assignment
//
//  Created by 오서영 on 6/27/24.
//

import UIKit

struct Content {
    let image: UIImage
    let name: String
}

extension Content {
    static func dummy() -> [Content] {
        return [
            Content(image: UIImage(named: "signal")!, name: "시그널"),
            Content(image: UIImage(named: "harry")!, name: "해리포터와 마법사의 돌"),
            Content(image: UIImage(named: "ring")!, name: "반지의 제왕"),
            Content(image: UIImage(named: "door")!, name: "스즈메의 문단속")
        ]
    }
}
