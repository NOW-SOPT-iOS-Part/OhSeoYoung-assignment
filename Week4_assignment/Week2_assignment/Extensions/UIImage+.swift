//
//  UIImage+.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import Foundation
import UIKit

extension UIImage {
    static var signalPoster: UIImage {
        return UIImage(named: "signalPoster")!
    }
    // 추가 이미지에 대해서도 같은 패턴을 사용할 수 있습니다.
    static var bearsLogo: UIImage {
        return UIImage(named: "bearsLogo")!
    }
    
    static var bearsSloganBlack: UIImage {
        return UIImage(named: "bearsSloganBlack")!
    }
    
    static var bearsSloganWhite: UIImage {
        return UIImage(named: "bearsSloganWhite")!
    }
    
    static var doorPoster: UIImage {
        return UIImage(named: "doorPoster")!
    }
    
    static var harrypotterPoster: UIImage {
        return UIImage(named: "harrypotterPoster")!
    }
    
    static var ringPoster: UIImage {
        return UIImage(named: "ringPoster")!
    }
    
    static var yellow: UIImage {
        return UIImage(named: "yellow")!
    }
    
    static var blue: UIImage {
        return UIImage(named: "blue")!
    }
    
    static var mainPoster: UIImage {
        return UIImage(named: "mainPoster")!
    }
    
    static var tvingTitleWhite: UIImage {
        return UIImage(named: "tvingTitleWhite")!
    }
    
    static var account: UIImage {
        return UIImage(named: "account")!
    }
    
    static var bird: UIImage {
        return UIImage(named: "bird")!
    }
    
    static var ten: UIImage {
        return UIImage(named: "ten")!
    }
    
    static var monster: UIImage {
        return UIImage(named: "monster")!
    }
    
    static var panda: UIImage {
        return UIImage(named: "panda")!
    }
    
    static var criminal: UIImage {
        return UIImage(named: "criminal")!
    }
}

let movieImageMapping: [String: UIImage] = [
    "범죄도시4": .criminal,
    "쿵푸팬더4": .panda,
    // 다른 영화 이름과 이미지 매핑 추가...
]
