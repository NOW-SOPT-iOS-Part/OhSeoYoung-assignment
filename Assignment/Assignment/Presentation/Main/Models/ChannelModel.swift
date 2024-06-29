//
//  ChannelModel.swift
//  Assignment
//
//  Created by 오서영 on 6/27/24.
//

import UIKit

struct Channel {
    let image: UIImage
    let rank: String
    let channel: String
    let content: String
    let rating: String
}

extension Channel {
    static func dummy() -> [Channel] {
        return [
            Channel(image: UIImage(named: "yellow")!, rank: "1", channel: "Mnet", content: "보이즈 플래닛 12화", rating: "80.0%"),
            Channel(image: UIImage(named: "blue")!, rank: "2", channel: "Mnet", content: "하트시그널 4화", rating: "12.0%"),
            Channel(image: UIImage(named: "blue")!, rank: "3", channel: "Mnet", content: "스즈메의 문단속", rating: "4.0%")
        ]
    }
}
