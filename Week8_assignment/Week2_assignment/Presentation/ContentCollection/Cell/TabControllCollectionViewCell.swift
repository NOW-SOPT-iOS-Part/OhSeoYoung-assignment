//
//  TabControllCollectionViewCell.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//


import UIKit

import SnapKit

final class TabControlCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "TabControlCollectionViewCell"
    
    // MARK: - Components
    
    private lazy var tabNameLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 17)
    }
    private lazy var bottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    // MARK: - Life Cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        hideOtherTabs()
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
            tabNameLabel,
            bottomView
        ].forEach { contentView.addSubview($0) }
        tabNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        bottomView.snp.makeConstraints {
            $0.top.equalTo(tabNameLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(3)
        }
    }
    
    func fetchData(model: Tab) {
        tabNameLabel.text = model.name
        contentView.snp.remakeConstraints {
            $0.width.equalTo(model.width)
        }
    }
    
    func hideOtherTabs() {
        if tabNameLabel.text != "홈" {
            bottomView.isHidden = true
        }
    }
}
