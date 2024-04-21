//
//  MainViewController.swift
//  Week2_assignment
//
//  Created by 오서영 on 2024/04/21.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let tvingLogoImageView = UIImageView()
    let accountImageView = UIImageView()
    let yourNameImageView = UIImageView()
    let contentLabel = UILabel()
    let seeAllLabel = UILabel()
    let underlineView = UIView()
    let pageControl = UIPageControl()
    
    let signalImageView = UIImageView()
    let harryPotterImageView = UIImageView()
    let ringImageView = UIImageView()
    let doorCheckImageView = UIImageView()
    
    let menuLabels = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"].map { title -> UILabel in
        let label = UILabel()
        label.text = title
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        return label
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        layoutViews()
    }
    
    func setupViews() {
        // 여기서 이미지 뷰들과 레이블을 설정하세요.
        
        // 스크롤 뷰 설정
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        // 이미지 뷰들 설정
        tvingLogoImageView.image = UIImage(named: "tving_logo 1")
        accountImageView.image = UIImage(named: "account")
        yourNameImageView.image = UIImage(named: "your_name")
        
        // 이미지들 설정
        signalImageView.image = UIImage(named: "signal")
        harryPotterImageView.image = UIImage(named: "harry_poter")
        ringImageView.image = UIImage(named: "ring")
        doorCheckImageView.image = UIImage(named: "door_check")
        
        // 레이블들 설정
        contentLabel.text = "티빙에서 꼭 봐야하는 콘텐츠"
        contentLabel.font = UIFont.systemFont(ofSize: 15)
        contentLabel.textColor = UIColor(hex: "#FFFFFF")
        
        seeAllLabel.text = "전체보기"
        seeAllLabel.font = UIFont.systemFont(ofSize: 11)
        seeAllLabel.textColor = UIColor(hex: "#828282")
        
        underlineView.backgroundColor = .white
        
        // UIPageControl 설정
       pageControl.numberOfPages = 8 // 가정한 페이지 수
       pageControl.currentPageIndicatorTintColor = .white
       pageControl.pageIndicatorTintColor = .gray
       
        
        menuLabels.forEach { contentView.addSubview($0) }
        
        // 라운드 코너
        let imageViews = [signalImageView, harryPotterImageView, ringImageView, doorCheckImageView]
        imageViews.forEach {
            $0.layer.cornerRadius = 3
            $0.layer.masksToBounds = true
        }
    }
    
    func layoutViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(yourNameImageView)
        contentView.addSubview(underlineView)
        contentView.addSubview(pageControl)
        
        contentView.addSubview(tvingLogoImageView)
        contentView.addSubview(accountImageView)
        
        contentView.addSubview(contentLabel)
        contentView.addSubview(seeAllLabel)
        
        contentView.addSubview(signalImageView)
        contentView.addSubview(harryPotterImageView)
        contentView.addSubview(ringImageView)
        contentView.addSubview(doorCheckImageView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(view)
        }
        
        
        tvingLogoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.left.equalToSuperview().offset(21)
            make.height.equalTo(25)
            make.width.equalTo(99)
        }
        
        accountImageView.snp.makeConstraints { make in
            make.width.equalTo(33)
            make.height.equalTo(31)
            make.top.equalToSuperview().offset(55)
            make.right.equalToSuperview().offset(-19)
        }
        
        yourNameImageView.snp.makeConstraints { make in
            make.width.equalTo(375)
            make.height.equalTo(498)
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(10)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(536) // 상단에서 536만큼 떨어진 위치
               make.left.equalToSuperview().offset(15) // 왼쪽에서 15만큼 떨어진 위치
               make.height.equalTo(23)
        }
        
        seeAllLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(547) // 상단에서 547만큼 떨어진 위치
                make.left.equalToSuperview().offset(319)
                make.width.equalTo(44)
                make.height.equalTo(20)
        }
        
        // 첫 번째 이미지인 signalImageView 설정
        signalImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 98, height: 146))
            make.top.equalTo(contentLabel.snp.bottom).offset(14)
            make.left.equalToSuperview().offset(20) // 슈퍼뷰 왼쪽 가장자리에서의 여백
        }

        // 두 번째 이미지인 harryPotterImageView 설정
        harryPotterImageView.snp.makeConstraints { make in
            make.size.equalTo(signalImageView)
            make.top.equalTo(signalImageView.snp.top) // 첫 번째 이미지와 수평 정렬
            make.left.equalTo(signalImageView.snp.right).offset(20) // 첫 번째 이미지와의 여백
        }

        // 세 번째 이미지인 ringImageView 설정
        ringImageView.snp.makeConstraints { make in
            make.size.equalTo(signalImageView)
            make.top.equalTo(signalImageView.snp.top) // 첫 번째 이미지와 수평 정렬
            make.left.equalTo(harryPotterImageView.snp.right).offset(20) // 두 번째 이미지와의 여백
        }

        // 네 번째 이미지인 doorCheckImageView 설정
        doorCheckImageView.snp.makeConstraints { make in
            make.size.equalTo(signalImageView)
            make.top.equalTo(signalImageView.snp.top) // 첫 번째 이미지와 수평 정렬
            make.left.equalTo(ringImageView.snp.right).offset(20) // 세 번째 이미지와의 여백
        }
        
        for label in menuLabels {
            contentView.addSubview(label)
        }
        
        // UIPageControl 배치
        pageControl.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
            make.top.equalTo(yourNameImageView.snp.bottom).offset(22) // 'your_name' 이미지 바로 아래에 위치
            make.height.equalTo(4) // UIPageControl의 높이 설정
        }
        
        // 첫 번째 메뉴 레이블에 대한 제약 조건을 설정합니다.
        let firstMenuLabel = menuLabels.first!
        firstMenuLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(99)
            make.left.equalToSuperview().offset(18)
        }
        
        // 첫 번째를 제외한 나머지 메뉴 레이블들에 대한 제약 조건을 설정합니다.
        var previousLabel = firstMenuLabel
        for label in menuLabels.dropFirst() {
            label.snp.makeConstraints { make in
                make.top.equalTo(firstMenuLabel.snp.top)
                make.left.equalTo(previousLabel.snp.right).offset(28)
            }
            previousLabel = label
        }
            
        // "홈" 레이블에 대한 밑줄 뷰 설정
        if let homeLabel = menuLabels.first {
            underlineView.snp.makeConstraints { make in
                make.top.equalTo(homeLabel.snp.bottom).offset(7) // "홈" 레이블 아래 작은 간격을 둡니다.
                make.centerX.equalTo(homeLabel.snp.centerX) // "홈" 레이블의 수평 중심과 맞춥니다.
                make.width.equalTo(homeLabel.snp.width) // "홈" 레이블의 너비와 같게 설정합니다.
                make.height.equalTo(3) // 밑줄의 높이를 2픽셀로 설정합니다.
            }
        }

        // contentView의 하단 설정 - 마지막 이미지에 기반해서 하단 제약을 추가합니다.
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(doorCheckImageView.snp.bottom).offset(20)
        }
        
        

        
        // contentLabel과 seeAllLabel의 위치를 조정해야 합니다.
        // 특히, left offset이 매우 크게 설정되어 있어서 이는 수정되어야 할 것 같습니다.
    }
}
