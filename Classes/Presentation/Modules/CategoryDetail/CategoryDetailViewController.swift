//
//  Created by Kamolbek on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol CategoryDetailViewInput: class {
    @discardableResult
    func update(with viewModel: CategoryDetailViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol CategoryDetailViewOutput: class {
    func viewDidLoad()
}

final class CategoryDetailViewController: UIViewController {

    private(set) var viewModel: CategoryDetailViewModel
    let output: CategoryDetailViewOutput

    var needsUpdate: Bool = true
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCellClass(FeedNewCell.self)
        
        return collectionView
    }()
    
    private lazy var navigationTitleView: NavitgationTitleView = {
        let titleText = viewModel.navigationTitle
        let subTitleText = viewModel.navigationSubTitle
        let navigationTitleView = NavitgationTitleView()
        navigationTitleView.set(titleText, and: subTitleText)
        
        return navigationTitleView
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .white
        
        return activityIndicator
    }()
    
    // MARK: -  Lifecycle

    init(viewModel: CategoryDetailViewModel, output: CategoryDetailViewOutput) {
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
        
        navigationItem.titleView = navigationTitleView
        view.addSubviews(collectionView, activityIndicatorView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.navigationBar.barStyle = .black
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        navigationTitleView.configureFrame {
            $0.sizeToFit()
        }
        collectionView.configureFrame {
            $0.equal(to: view)
        }
        activityIndicatorView.configureFrame {
            $0.center()
            $0.height(44).width(44)
        }
    }

    // MARK: -  Actions
}

// MARK: -  CategoryDetailViewInput

extension CategoryDetailViewController: CategoryDetailViewInput, ViewUpdatable {

    func setNeedsUpdate() {
        needsUpdate = true
    }

    @discardableResult
    func update(with viewModel: CategoryDetailViewModel, animated: Bool) -> Bool {
        
        let oldViewModel = self.viewModel
        
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        
        self.viewModel = viewModel
        needsUpdate = false
        
        update(new: viewModel, old: oldViewModel, keyPath: \.isLoading) { isLoading in
            viewModel.isLoading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        }
        
        update(new: viewModel, old: oldViewModel, keyPath: \.cellModels) { feedSectionModel in
            collectionView.reloadData()
        }

        return true
    }
}

// MARK: -  UICollectionViewDataSource

extension CategoryDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellModels?.count ?? 0
    }
    
    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath ) -> UICollectionViewCell {
        
        let cell: FeedNewCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.authorNameLabel.text = viewModel.cellModels?[safe: indexPath.row]?.userName
        cell.createdDateLabel.text = viewModel.cellModels?[safe: indexPath.row]?.date
        cell.setupLikesLabel(using: viewModel.cellModels?[safe: indexPath.row]?.likes ?? "")
        cell.layoutSubviews()
        cell.imageView.nuke_setImage(with: viewModel.cellModels?[safe: indexPath.row]?.imageURL)
        
        return cell
    }
}

// MARK: -  UICollectionViewDelegate

extension CategoryDetailViewController: UICollectionViewDelegate {
    
}

// MARK: -  UICollectionViewDelegateFlowLayout

extension CategoryDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        guard let cellModel = viewModel.cellModels?[safe: indexPath.row] else {
            return .zero
        }
        
        let ratio: CGFloat = cellModel.height / cellModel.width
        let resultSize: CGSize = .init(width: collectionView.bounds.width, height:collectionView.bounds.width * ratio)
        
        return resultSize
    }
}
