//
//  PosterCollectionViewCell.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//


import UIKit

import SnapKit

final class PosterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "PosterCollectionViewCell"
    
    // MARK: - Components
    
    private let posterImageView = UIImageView().then {
        $0.image = .signalPoster
        $0.layer.cornerRadius = 3
    }
    private lazy var posterTitleLabel = UILabel().then {
        $0.text = "시그널"
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 500, size: 10)
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func setLayout() {
        [
            posterImageView,
            posterTitleLabel
        ].forEach { contentView.addSubview($0) }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(146)
        }
        posterTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(3)
            $0.leading.equalToSuperview()
        }
    }
    
    func fetchData(model: Poster) {
        posterTitleLabel.text = model.name
        posterImageView.image = model.image
    }
}

