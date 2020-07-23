//
//  Created by Kamolbek on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol FeedViewInput: class {
    @discardableResult
    func update(with viewModel: FeedViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol FeedViewOutput: class {
    func viewDidLoad()
    func viewDidSelect(categoryIn indexPath: IndexPath)
    func viewNeedsNewPage()
    func viewDidPressLoginButton()
}

final class FeedViewController: UIViewController {
    
    private enum Constant {
        static let valueOf_44: CGFloat = 44
    }
    
    private(set) var viewModel: FeedViewModel
    let output: FeedViewOutput
    
    var needsUpdate: Bool = true
    static let sizingHeader: FeedCollectionHeaderView = .init()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.registerHeaderViewClass(FeedCollectionHeaderView.self)
        collectionView.registerCellClass(FeedExploreCell.self)
        collectionView.registerCellClass(FeedNewCell.self)
        return collectionView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        return activityIndicator
    }()
    
    // MARK: -  Lifecycle
    
    init(viewModel: FeedViewModel, output: FeedViewOutput) {
        self.viewModel = viewModel
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: Asset.MainFeedModule.loginIcon.image,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLoginButton))
        view.addSubviews(collectionView, activityIndicatorView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.configureFrame {
            $0.equal(to: view)
        }
        activityIndicatorView.configureFrame {
            $0.center()
            $0.height(Constant.valueOf_44).width(Constant.valueOf_44)
        }
    }
    
    // MARK: -  Actions
    
    @objc private func handleLoginButton() {
        output.viewDidPressLoginButton()
    }
}

// MARK: -  FeedViewInput

extension FeedViewController: FeedViewInput, ViewUpdatable {
    
    func setNeedsUpdate() {
        needsUpdate = true
    }
    
    @discardableResult
    func update(with viewModel: FeedViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        
        self.viewModel = viewModel
        needsUpdate = false
        
        update(new: viewModel, old: oldViewModel, keyPath: \.isLoading) { _ in
            viewModel.isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        }
        
        update(new: viewModel, old: oldViewModel, keyPath: \.feedSectionModels) { _ in
            collectionView.reloadData()
        }
        
        return true
    }
}

// MARK: -  UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.feedSectionModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let sectionModel = viewModel.feedSectionModels?[safe: indexPath.section]  else {
            return UICollectionReusableView()
        }
        
        let sectionView: FeedCollectionHeaderView = collectionView.dequeueReusableHeaderView(for: indexPath)
        sectionView.titleLabel.text = sectionModel.title
        sectionView.layoutSubviews()
        
        return sectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        guard let sectionModel = viewModel.feedSectionModels?[safe: section] else {
            return 0
        }
        
        return sectionModel.cellModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let exploreCell: FeedExploreCell = collectionView.dequeueReusableCell(for: indexPath)
            exploreCell.cellModelResolver = { [weak self] in
                return self?.viewModel.feedSectionModels?[safe: indexPath.section]?.cellModels as? [FeedExploreCellModel] ?? []
            }
            exploreCell.layoutSubviews()
            exploreCell.update()
            exploreCell.onSelect = { [weak self] internalIndex in
                self?.output.viewDidSelect(categoryIn: internalIndex)
            }
            
            return exploreCell
        }
        
        guard let cellModel =
            viewModel.feedSectionModels?[safe: indexPath.section]?.cellModels?[safe: indexPath.row] as? FeedNewCellModel else {
            return UICollectionViewCell()
        }
        
        let cell: FeedNewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.authorNameLabel.text = cellModel.userName
        cell.createdDateLabel.text = cellModel.date
        cell.setupLikesLabel(using: cellModel.likes)
        cell.layoutSubviews()
        cell.imageView.nuke_setImage(with: cellModel.imageURL)
        
        return cell
    }
}

// MARK: -  UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let sectionModel = viewModel.feedSectionModels?[safe: section]  else {
            return .zero
        }
        
        type(of: self).sizingHeader.titleLabel.text = sectionModel.title
        return type(of: self).sizingHeader.sizeThatFits(collectionView.bounds.size)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height * 0.27)
        }
        
        let feedSection = viewModel.feedSectionModels?[safe: indexPath.section]
        let cellModelData = feedSection?.cellModels?[safe: indexPath.row]
        
        guard let cellModel = cellModelData as? FeedNewCellModel else {
            return .zero
        }
        
        let ratio: CGFloat = cellModel.height / cellModel.width
        let resultSize: CGSize = .init(width: collectionView.bounds.width,
                                       height: collectionView.bounds.width * ratio)
        
        return resultSize
    }
}

// MARK: -  UICollectionScrollView

extension FeedViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxVerticalOffset = scrollView.contentSize.height - (scrollView.frame.height * 0.3)
        let currentOffset = scrollView.contentOffset.y
        let percentage = currentOffset/maxVerticalOffset * 100
        
        if percentage >= 60.0 {
            output.viewNeedsNewPage()
        }
    }
}
