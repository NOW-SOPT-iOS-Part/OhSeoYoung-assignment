//
//  MainViewController.swift
//  Week3_assignment
//
//  Created by 오서영 on 2024/05/03.
//

import UIKit
import SnapKit
import Then

struct Tab {
    let name: String
    let width: CGFloat
}

/// 티빙 메인 화면
final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    let posterHeight = 498
    let deviceWidth = UIScreen.main.bounds.width
    
    let posterImages: [UIImage] = [.mainPoster, .harrypotterPoster, .doorPoster, .ringPoster]
    let headers: [String] = ["티빙에서 꼭 봐야하는 콘텐츠", "인기 LIVE 채널", "1화 무료! 파라마운트+ 인기 시리즈", "", "마술보다 더 신비로운 영화(신비로운 영화사전님)"]
    let tabs: [Tab] = [
        Tab(name: "홈", width: 15),
        Tab(name: "실시간", width: 55),
        Tab(name: "TV프로그램", width: 85),
        Tab(name: "영화", width: 35),
        Tab(name: "파라마운트+", width: 90)
    ]
    let posters = Poster.dummyData()
//    var livePrograms = LiveProgram.dummyData()
    var livePrograms: [LiveProgram] = []
    let baseballSlogans = BaseballSlogan.dummyData()
    
    // MARK: - Components
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.delegate = self
    }
    
    private let contentView = UIView()
    
    private let tvingTopLogoImageView = UIImageView().then {
        $0.image = .tvingTitleWhite
        $0.contentMode = .scaleAspectFit  // 이미지의 비율을 유지하면서 채우기
    }
    
    private let bearsLogoButton = UIButton().then {
//        $0.setImage(.account, for: .normal)
        let originalImage = UIImage(named: "account") // Assume 'account' is your image name in assets
        let resizedImage = originalImage?.resized(to: CGSize(width: 33, height: 31))
        $0.setImage(resizedImage, for: .normal)
    }
    
    private lazy var rightTopButtonStackView = UIStackView(arrangedSubviews: [bearsLogoButton]).then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    private let bufferView = UIView().then {
        $0.backgroundColor = .none
    }
    
    private let flowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.minimumInteritemSpacing = 28
        $0.sectionInset = .init(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    private lazy var tabControlCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
        $0.tag = 1
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .none
    }
    
    private lazy var mainPosterImageView = UIImageView().then {
        $0.image = posterImages[pageControl.currentPage]
        $0.contentMode = .scaleAspectFill
    }
    
    private let posterTitleLabel = UILabel().then {
        $0.text = "너의 이름은"
        $0.textColor = .white
        $0.font = .pretendard(weight: 700, size: 25)
        $0.isHidden = true
    }
    
    private let posterDetailLabel = UILabel().then {
        $0.text = "텍스트"
        $0.textColor = .white
        $0.font = .pretendard(weight: 400, size: 17)
        $0.lineBreakMode = .byTruncatingTail
        $0.numberOfLines = 2
        $0.isHidden = true
    }
    
    private lazy var posterScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.isPagingEnabled = true
        $0.delegate = self
    }
    
    private let posterContentView = UIView()
    
    private lazy var pageControl = UIPageControl().then {
        $0.numberOfPages = posterImages.count
        $0.currentPage = 0
        $0.isUserInteractionEnabled = false
        $0.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
    
    let config = UICollectionViewCompositionalLayoutConfiguration().then {
        $0.interSectionSpacing = 18
    }
    
    lazy var compositionalLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, _) -> NSCollectionLayoutSection? in
        return self.createSection(for: sectionIndex)
    }, configuration: config)
    
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout).then {        $0.tag = 2
        $0.backgroundColor = .black
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        register()
        setLayout()
        
        NetworkManager.shared.fetchBoxOfficeData { [weak self] (livePrograms, error) in
                if let error = error {
                    // 에러 발생 시 콘솔에 에러를 출력합니다.
                    print("Error fetching data: \(error)")
                    return
                }
                
                // 데이터 로딩이 성공적으로 완료되면,
                if let livePrograms = livePrograms {
                    // 콘솔에 가져온 프로그램 데이터를 출력합니다.
                    print("Fetched live programs: \(livePrograms)")
                    
                    // MainViewController의 livePrograms 배열에 데이터를 저장합니다.
                    self?.livePrograms = livePrograms
                    
                    // UI 업데이트는 메인 스레드에서 수행합니다.
                    DispatchQueue.main.async { [weak self] in
                        // UICollectionView를 리로드하여 UI에 반영합니다.
                        self?.mainCollectionView.reloadData()
                    }
                }
            }
      

        
    }
    
//    // UI 업데이트 메서드
//   func updateUI() {
//       DispatchQueue.main.async { [weak self] in
//           // 예: 테이블 뷰 업데이트
////           print(self?.livePrograms ?? <#default value#>)
//           print(self?.livePrograms)
//           self?.mainCollectionView.reloadData()
//       }
//   }
    
    // MARK: - Helpers
    
    private func register() {
        tabControlCollectionView.register(TabControlCollectionViewCell.self, forCellWithReuseIdentifier: TabControlCollectionViewCell.identifier)
        mainCollectionView.register(LiveCollectionViewCell.self, forCellWithReuseIdentifier: LiveCollectionViewCell.identifier)
        mainCollectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.identifier)
        mainCollectionView.register(BaseballCollectionViewCell.self, forCellWithReuseIdentifier: BaseballCollectionViewCell.identifier)
        mainCollectionView.register(HeaderCollectionView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                        withReuseIdentifier: HeaderCollectionView.identifier)
    }
    
    private func setLayout() {
        [
            scrollView,
            bufferView
        ].forEach { self.view.addSubview($0) }
        
        scrollView.addSubview(contentView)
        posterScrollView.addSubview(posterContentView)
        
        view.addSubview(tvingTopLogoImageView)
        
        [
            mainPosterImageView,
            tvingTopLogoImageView,
            rightTopButtonStackView,
            tabControlCollectionView,
            posterScrollView,
            pageControl,
            mainCollectionView
        ].forEach { contentView.addSubview($0) }
        [
            posterTitleLabel,
            posterDetailLabel
        ].forEach { posterContentView.addSubview($0) }
        
        
        tvingTopLogoImageView.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(5)  // Top margin 설정
                make.leading.equalToSuperview().inset(20)  // Leading margin 설정
                make.width.equalTo(99)  // 너비 설정
                make.height.equalTo(22)  // 높이 설정
            }
        
        
        bufferView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalTo(80)
        }
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            $0.height.equalTo(1000)
        }
        
        mainPosterImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterHeight)
        }
        tvingTopLogoImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(5)
            $0.leading.equalToSuperview().inset(20)
        }
        rightTopButtonStackView.snp.makeConstraints {
            $0.centerY.equalTo(tvingTopLogoImageView)
            $0.trailing.equalToSuperview().inset(20)
        }
        tabControlCollectionView.snp.makeConstraints {
            $0.top.equalTo(bufferView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(40)
        }
        posterScrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(posterHeight)
        }
        posterContentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.greaterThanOrEqualTo(Int(deviceWidth) * posterImages.count)
        }
        posterTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalTo(mainPosterImageView).offset(-70)
        }
        posterDetailLabel.snp.makeConstraints {
            $0.leading.equalTo(posterTitleLabel)
            $0.top.equalTo(posterTitleLabel.snp.bottom).offset(15)
        }
        pageControl.snp.makeConstraints {
            $0.top.equalTo(mainPosterImageView.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(-23)
        }
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(pageControl.snp.bottom).offset(25)
            $0.leading.trailing.bottom.equalToSuperview().inset(15)
        }
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection? {
        switch sectionIndex {
            case 0, 2, 4:
                return createPosterItem()
            case 1:
                return createLiveItem()
            case 3:
                return createBaseballSloganItem()
            default:
            return createPosterItem()
        }
    }
    
    private func createPosterItem() -> NSCollectionLayoutSection? {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .estimated(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 8
        
        // HeaderView의 자리를 SectionLayout 안에서 잡아주는 코드
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        
        return section
    }
    
    private func createLiveItem() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.4), heightDimension: .estimated(155))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(7)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.interGroupSpacing = 7
        
        // HeaderView의 자리를 SectionLayout 안에서 잡아주는 코드
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]

        return section
    }
    
    private func createBaseballSloganItem() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(58))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(0)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous // 가로 스크롤
        section.contentInsets = NSDirectionalEdgeInsets(top: 27, leading: 0, bottom: 30, trailing: 0)
        return section
    }
    
    // MARK: - Actions
    
}

// MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.y, bufferView.frame.minY)
        
        if scrollView == self.scrollView {
            // sticky 타이밍을 계산
            // 야매로 구현함 ㅎㅎ
            let shouldShowSticky = scrollView.contentOffset.y >= bufferView.frame.minY
            bufferView.backgroundColor = shouldShowSticky ? .black : .none
            tabControlCollectionView.backgroundColor = shouldShowSticky ? .black : .none
            bufferView.snp.updateConstraints {
                $0.top.equalToSuperview()
                $0.width.equalToSuperview()
                $0.height.equalTo(shouldShowSticky ? 40 : 80)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 한 페이지만큼 스크롤 하면
        if fmod(posterScrollView.contentOffset.x, posterScrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(posterScrollView.contentOffset.x / posterScrollView.frame.maxX)
            // 페이지 위치 변경
            let pageIndex = Int(posterScrollView.contentOffset.x / posterScrollView.frame.width)
            pageControl.currentPage = pageIndex

            // mainPosterImageView의 이미지 업데이트
            mainPosterImageView.image = posterImages[pageIndex]
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCollectionView.identifier, for: indexPath) as! HeaderCollectionView
            header.fetchData(headers[indexPath.section])
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView.tag == 1 {
            return 1
        } else {
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 {
            return tabs.count
        } else {
            switch section {
            case 0, 2, 4:
                return posters.count
            case 1:
                print("Number of live programs: \(livePrograms.count)")
                return livePrograms.count
            case 3:
                return baseballSlogans.count
            default:
                return posters.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 탭 컨트롤 컬렉션 뷰 (tag == 1)
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabControlCollectionViewCell.identifier, for: indexPath) as? TabControlCollectionViewCell else {
                fatalError("Unable to dequeue TabControlCollectionViewCell")
            }
            cell.fetchData(model: tabs[indexPath.row])
            return cell
        }
        // 메인 컬렉션 뷰 (tag == 2)
        else if collectionView.tag == 2 {
            switch indexPath.section {
            case 0, 2, 4: // 포스터 아이템 셀
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as? PosterCollectionViewCell else {
                    fatalError("Unable to dequeue PosterCollectionViewCell")
                }
                cell.fetchData(model: posters[indexPath.row])
                return cell
            
            case 1: // 라이브 프로그램 아이템 셀
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LiveCollectionViewCell.identifier, for: indexPath) as? LiveCollectionViewCell else {
                    fatalError("Unable to dequeue LiveCollectionViewCell")
                }
                if indexPath.row < livePrograms.count {
                    let liveProgram = livePrograms[indexPath.row]
                    cell.fetchData(model: liveProgram)
                }
                return cell
            
            case 3: // 야구 슬로건 아이템 셀
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaseballCollectionViewCell.identifier, for: indexPath) as? BaseballCollectionViewCell else {
                    fatalError("Unable to dequeue BaseballCollectionViewCell")
                }
                cell.fetchData(model: baseballSlogans[indexPath.row])
                return cell
            
            default:
                fatalError("Unexpected section \(indexPath.section)")
            }
        }
        // 기본 셀 반환
        return UICollectionViewCell()
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1 {
            return CGSize(width: tabs[indexPath.row].width, height: 37)
        } else {
            return CGSize()
        }
    }
}

extension UIImage {
    /// Resizes the image to specified width and height.
    func resized(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
