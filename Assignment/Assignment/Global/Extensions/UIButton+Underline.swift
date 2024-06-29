//
//  UIButton+.swift
//  Assignment
//
//  Created by 오서영 on 6/26/24.
//

import UIKit

extension UIButton {
    func setUnderline() {
        guard let title = self.title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
