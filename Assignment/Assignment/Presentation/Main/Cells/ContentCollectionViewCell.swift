//
//  ContentCollectionViewCell.swift
//  Assignment
//
//  Created by 오서영 on 6/27/24.
//

import UIKit

import SnapKit
import Then

class ContentCollectionViewCell: UICollectionViewCell {
    
    
    static let cellID = "mainCollectionViewCell"
    
    
    // MARK: - Components
    
    final let contentImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "your_name")
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    final let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Medium", size: 10)
        $0.textColor = UIColor(named: "gray2")
        $0.text = "contentLabel"
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Functions
    
    private func setLayout() {
        [
            contentImageView, contentLabel
        ].forEach { self.contentView.addSubview($0) }
    
    
        contentImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(98)
            $0.height.equalTo(146)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(7)
            $0.leading.equalToSuperview().offset(2)
            $0.bottom.equalToSuperview()
            $0.width.equalTo(98)
        }
    }
}
