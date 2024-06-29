//
//  LiveCollectionViewCell.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit

import SnapKit

/// 티빙 라이브 프로그램 컬렉션뷰 셀
final class LiveCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "LiveCollectionViewCell"
    
    // MARK: - Components
    private let movieImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 3
        $0.clipsToBounds = true
    }
    
    private let rankLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 700, size: 19)
    }
    
    private let openDateLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    private let movieNameLabel = UILabel().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    private let salesShareLabel = UILabel().then {
        $0.textColor = .gray9C
        $0.font = .pretendard(weight: 400, size: 10)
    }
    
    // MARK: - 레이아웃 설정
    private func setLayout() {
        [
            movieImageView,
            rankLabel,
            openDateLabel,
            movieNameLabel,
            salesShareLabel
        ].forEach { contentView.addSubview($0) }
        
        movieImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(movieImageView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(6)
        }
        openDateLabel.snp.makeConstraints {
            $0.top.equalTo(rankLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(6)
        }
        movieNameLabel.snp.makeConstraints {
            $0.top.equalTo(openDateLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(6)
        }
        salesShareLabel.snp.makeConstraints {
            $0.top.equalTo(movieNameLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(6)
        }
        
    }
    
    // MARK: - 데이터 바인딩
    func fetchData(model: LiveProgram) {
        // 이미지 처리 로직은 앱의 설계에 따라 적절히 조정
        movieImageView.image = model.image
        rankLabel.text = model.rank
        openDateLabel.text = model.openDate
        movieNameLabel.text = model.movieName
        salesShareLabel.text = model.salesShare
    }
}
