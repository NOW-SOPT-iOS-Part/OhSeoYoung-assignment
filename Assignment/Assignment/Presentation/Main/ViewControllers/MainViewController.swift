//
//  MainViewController.swift
//  Assignment
//
//  Created by 오서영 on 6/27/24.
//
import UIKit
import SnapKit
import SwiftUI
import Then

class MainViewController: UIViewController {
    
    let contentDummy = Content.dummy()
    let channelDummy = Channel.dummy()
    let menuData = ["홈", "실시간", "TV프로그램", "영화", "파라마운트+"]
    
    final private let scrollView = UIScrollView().then {
            $0.backgroundColor = .black
        }
        
    final private let contentView = UIView()
    
    final private let logoImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "tving_logo")
        $0.contentMode = .scaleAspectFit
    }
    
    final private let profileImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "profile")
        $0.contentMode = .scaleToFill
    }
    
    final private let posterView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "your_name")
        $0.contentMode = .scaleAspectFill
    }
    
   final private let contentLabel: UILabel = UILabel().then {
       $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
       $0.textColor = .white
       $0.text = "티빙에서 꼭 봐야하는 컨텐츠"
   }
   
   final private lazy var moreContentButton: UIButton = UIButton().then {
       $0.setTitle("전체보기", for: .normal)
       $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
       $0.tintColor = .white
       $0.setTitleColor(UIColor(named: "gray2"), for: .normal)
       $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 11)
       $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
       $0.semanticContentAttribute = .forceRightToLeft
   }
   
   final private lazy var contentCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
       $0.scrollDirection = .horizontal
       $0.minimumLineSpacing = 10
       $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
   }).then {
       $0.backgroundColor = .clear
       $0.showsHorizontalScrollIndicator = false
       $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
   }
   
   final private let channelLabel: UILabel = UILabel().then {
       $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
       $0.textColor = .white
       $0.text = "인기 LIVE 채널"
   }
   
   final private lazy var moreChannelButton: UIButton = UIButton().then {
       $0.setTitle("전체보기", for: .normal)
       $0.tintColor = .white
       $0.setTitleColor(UIColor(named: "gray2"), for: .normal)
       $0.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 10)
       $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
       $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
       $0.semanticContentAttribute = .forceRightToLeft
   }
   
   final private lazy var channelCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
       $0.scrollDirection = .horizontal
       $0.minimumLineSpacing = 10
       $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
   }).then {
       $0.backgroundColor = .clear
       $0.showsHorizontalScrollIndicator = false
       $0.register(ChannelCollectionViewCell.self, forCellWithReuseIdentifier: ChannelCollectionViewCell.cellID)
   }
   
   final private let paramountLabel: UILabel = UILabel().then {
       $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
       $0.textColor = .white
       $0.text = "1화 무료! 파라마운트+ 인기 시리즈"
   }
   
   final private lazy var moreParamountButton: UIButton = UIButton().then {
       $0.setTitle("전체보기", for: .normal)
       $0.tintColor = .white
       $0.setTitleColor(UIColor(named: "gray2"), for: .normal)
       $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 11)
       $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
       $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
       $0.semanticContentAttribute = .forceRightToLeft
   }
   
   final private lazy var paramountCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
       $0.scrollDirection = .horizontal
       $0.minimumLineSpacing = 10
       $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
   }).then {
       $0.backgroundColor = .clear
       $0.showsHorizontalScrollIndicator = false
       $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
   }
   
   final private let firstImageView: UIImageView = UIImageView().then {
       $0.image = .firstAD
       $0.contentMode = .scaleAspectFill
   }
   
   final private let secondImageView: UIImageView = UIImageView().then {
       $0.image = .secondAD
       $0.contentMode = .scaleAspectFill
   }
   
   final private let magicLabel: UILabel = UILabel().then {
       $0.font = UIFont(name: "Pretendard-SemiBold", size: 15)
       $0.textColor = .white
       $0.text = "마술보다 더 신비로운 영화(신비로운 영화사전님)"
   }
   
   final private lazy var moreMagicButton: UIButton = UIButton().then {
       $0.setTitle("전체보기", for: .normal)
       $0.tintColor = .white
       $0.setTitleColor(UIColor(named: "gray2"), for: .normal)
       $0.titleLabel?.font = UIFont(name: "Pretendard-SemiBold", size: 11)
       $0.setImage(UIImage(systemName: "chevron.right"), for: .normal)
       $0.setPreferredSymbolConfiguration(.init(scale: .small), forImageIn: .normal)
       $0.semanticContentAttribute = .forceRightToLeft
   }
   
   final private lazy var magicCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout().then {
       $0.scrollDirection = .horizontal
       $0.minimumLineSpacing = 10
       $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
   }).then {
       $0.backgroundColor = .clear
       $0.showsHorizontalScrollIndicator = false
       $0.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.cellID)
   }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setLayout()
        setDelegate()
    }
    
    final private func setLayout() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
            [
                posterView, contentLabel, moreContentButton, contentCollectionView, channelLabel,
                moreChannelButton, channelCollectionView, paramountLabel, moreParamountButton, paramountCollectionView,
                firstImageView, secondImageView, magicLabel, moreMagicButton, magicCollectionView
            ].forEach { contentView.addSubview($0) }
            [
                logoImageView, profileImageView
            ].forEach { posterView.addSubview($0) }
        
    
        scrollView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
            
            contentView.snp.makeConstraints {
                $0.edges.width.equalToSuperview()
            }
            
            posterView.snp.makeConstraints {
                $0.top.leading.trailing.equalToSuperview()
                $0.height.equalTo(498)
            }
            
            logoImageView.snp.makeConstraints {
                $0.top.equalToSuperview().offset(58)
                $0.leading.equalToSuperview().offset(11)
                $0.width.equalTo(99)
                $0.height.equalTo(25)
            }
            
            profileImageView.snp.makeConstraints {
                $0.centerY.equalTo(logoImageView)
                $0.trailing.equalToSuperview().inset(11)
                $0.width.height.equalTo(33)
            }

            contentLabel.snp.makeConstraints {
                $0.top.equalTo(posterView.snp.bottom).offset(43)
                $0.leading.equalToSuperview().offset(16)
            }
            
            moreContentButton.snp.makeConstraints {
                $0.centerY.equalTo(contentLabel)
                $0.trailing.equalToSuperview().inset(16)
            }
            
            contentCollectionView.snp.makeConstraints {
                $0.top.equalTo(contentLabel.snp.bottom).offset(13)
                $0.leading.equalTo(contentLabel)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(166)
            }
            
            channelLabel.snp.makeConstraints {
                $0.top.equalTo(contentCollectionView.snp.bottom).offset(20)
                $0.leading.equalTo(contentLabel)
            }
            
            moreChannelButton.snp.makeConstraints {
                $0.centerY.equalTo(channelLabel)
                $0.trailing.equalTo(moreContentButton.snp.trailing)
            }
            
            channelCollectionView.snp.makeConstraints {
                $0.top.equalTo(channelLabel.snp.bottom).offset(13)
                $0.leading.equalTo(channelLabel)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(166)
            }
            
            paramountLabel.snp.makeConstraints {
                $0.top.equalTo(channelCollectionView.snp.bottom).offset(18)
                $0.leading.equalTo(contentLabel)
            }
            
            moreParamountButton.snp.makeConstraints {
                $0.centerY.equalTo(paramountLabel)
                $0.trailing.equalTo(moreContentButton.snp.trailing)
            }
            
            paramountCollectionView.snp.makeConstraints {
                $0.top.equalTo(paramountLabel.snp.bottom).offset(13)
                $0.leading.equalTo(paramountLabel)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(166)
            }
            
            firstImageView.snp.makeConstraints {
                $0.top.equalTo(paramountCollectionView.snp.bottom).offset(50)
                $0.leading.equalToSuperview()
                $0.height.equalTo(58)
                $0.width.equalTo(view.frame.width / 2)
            }
            
            secondImageView.snp.makeConstraints {
                $0.top.height.width.equalTo(firstImageView)
                $0.trailing.equalToSuperview()
            }
            
            magicLabel.snp.makeConstraints {
                $0.top.equalTo(firstImageView.snp.bottom).offset(50)
                $0.leading.equalTo(contentLabel)
            }
            
            moreMagicButton.snp.makeConstraints {
                $0.centerY.equalTo(magicLabel)
                $0.trailing.equalTo(moreContentButton.snp.trailing)
            }
            
            magicCollectionView.snp.makeConstraints {
                $0.top.equalTo(magicLabel.snp.bottom).offset(18)
                $0.leading.equalTo(magicLabel)
                $0.trailing.equalToSuperview()
                $0.height.equalTo(166)
                $0.bottom.equalToSuperview().inset(20)
            }
        }
    
        final private func setDelegate() {
            
            contentCollectionView.delegate = self
            contentCollectionView.dataSource = self
            
            channelCollectionView.delegate = self
            channelCollectionView.dataSource = self
            
            paramountCollectionView.delegate = self
            paramountCollectionView.dataSource = self
            
            magicCollectionView.delegate = self
            magicCollectionView.dataSource = self
            
            }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == channelCollectionView { return channelDummy.count }
        
        return contentDummy.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.cellID, for: indexPath) as? ContentCollectionViewCell
        
        if collectionView == channelCollectionView {
            let channelCell = (collectionView.dequeueReusableCell(withReuseIdentifier: ChannelCollectionViewCell.cellID, for: indexPath) as? ChannelCollectionViewCell)!
            
            channelCell.channelImageView.image = channelDummy[indexPath.row].image
            channelCell.channelLabel.text = channelDummy[indexPath.row].channel
            channelCell.contentLabel.text = channelDummy[indexPath.row].content
            channelCell.rankLabel.text = channelDummy[indexPath.row].rank
            channelCell.ratingLabel.text = channelDummy[indexPath.row].rating
            
            return channelCell
        }
        
        contentCell?.contentImageView.image = contentDummy[indexPath.row].image
        contentCell?.contentLabel.text = contentDummy[indexPath.row].name
        
        return contentCell!
    }
}


// 프리뷰를 위한 코드
struct MainViewController_Preview: PreviewProvider {
    static var previews: some View {
        MainViewControllerRepresentable().edgesIgnoringSafeArea(.all)
    }
}

struct MainViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> MainViewController {
        return MainViewController()
    }
    
    func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
    }
}
