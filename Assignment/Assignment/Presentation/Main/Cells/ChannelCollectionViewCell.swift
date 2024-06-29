//
//  ChannelCollectionViewCell.swift
//  Assignment
//
//  Created by 오서영 on 6/27/24.
//

import UIKit

import SnapKit
import Then


class ChannelCollectionViewCell: UICollectionViewCell {
    

    static let cellID = "mainCollectionViewCell"
    
    
    // MARK: - Components
    
    final let channelImageView: UIImageView = UIImageView().then {
        $0.layer.cornerRadius = 3
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    final let rankLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Bold", size: 19)
        $0.textColor = .white
        $0.text = "1"
    }
    
    final let channelLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textColor = .white
        $0.text = "channelLabel"
    }
    
    final let contentLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textColor = UIColor(named: "gray2")
        $0.text = "contentLabel"
    }
    
    final let ratingLabel: UILabel = UILabel().then {
        $0.font = UIFont(name: "Pretendard-Regular", size: 10)
        $0.textColor = UIColor(named: "gray2")
        $0.text = "ratingLabel"
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
            channelImageView, rankLabel, channelLabel, contentLabel, ratingLabel
        ].forEach { self.contentView.addSubview($0) }
        
        
        channelImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(95)
            $0.width.equalTo(170)
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalTo(channelImageView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(3)
        }
        
        channelLabel.snp.makeConstraints {
            $0.top.equalTo(rankLabel)
            $0.leading.equalTo(rankLabel.snp.trailing).offset(5)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(channelLabel.snp.bottom).offset(7)
            $0.leading.equalTo(channelLabel)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(7)
            $0.leading.equalTo(channelLabel)
            $0.bottom.equalToSuperview()
        }
    }
    
    func configure(with model: DailyBoxOffice) {
        channelLabel.text = model.movieNm
        contentLabel.text = model.openDt
        rankLabel.text = model.rank
        ratingLabel.text = model.salesShare
        channelImageView.image = UIImage(named: "yellow")
    }
    
}
