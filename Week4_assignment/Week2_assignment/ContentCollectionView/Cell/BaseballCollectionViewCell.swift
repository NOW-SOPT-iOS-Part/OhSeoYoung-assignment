//
//  BaseballCollectionViewCell.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//


import UIKit

import SnapKit

final class BaseballCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "BaseballCollectionViewCell"
    
    // MARK: - Components
    
    private let baseballImageView = UIImageView().then {
        $0.image = .bearsSloganBlack
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
        contentView.addSubview(baseballImageView)
        
        baseballImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 더미 데이터를 뷰에 연결
    func fetchData(model: BaseballSlogan) {
        baseballImageView.image = model.image
    }
}
