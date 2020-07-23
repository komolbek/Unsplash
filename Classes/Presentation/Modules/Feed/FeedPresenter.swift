//  Created by Kamolbek on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.

import Foundation

final class FeedPresenter {
    
    typealias Dependencies = HasPhotoService
    
    weak var view: FeedViewInput?
    var output: FeedModuleOutput?
    
    var state: FeedState
    
    private let dependencies: Dependencies
    
    init(state: FeedState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    private func dispatchData() {
        let dispatchGroup = DispatchGroup()
        state.isLoading = true
        self.update(animated: false)
        
        dispatchGroup.enter()
        dependencies.photoService.fetchPhotos(pageNumber: state.imagePageCounter,
                                              success: { [weak self] images in
            if let images = images, let self = self {
                self.state.feedImages.append(contentsOf: images)
                self.state.imagePageCounter += 1
            }
            dispatchGroup.leave()
        }) { error in
            print(error.localizedDescription)
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        dependencies.photoService.fetchCategories(success: { [weak self] categories in
            if let categories = categories, let self = self {
                self.state.feedCategories = categories
            }
            dispatchGroup.leave()
        }) { error in
            print(error.localizedDescription)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            self.state.isLoading = false
            self.update(animated: false)
        }
    }
    
    private func fetchNewData() {
        state.isLoading = true
        self.update(animated: false)
        
        dependencies.photoService.fetchPhotos(pageNumber: state.imagePageCounter,
                                              success: { [weak self] images in
            if let images = images, let self = self {
                self.state.feedImages.append(contentsOf: images)
                self.state.isLoading = false
                self.state.imagePageCounter += 1
                
                DispatchQueue.main.async {
                    self.update(animated: false)
                }
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}

// MARK: -  FeedViewOutput

extension FeedPresenter: FeedViewOutput {
    
    func viewDidLoad() {
        dispatchData()
    }
    
    func viewNeedsNewPage() {
        guard !state.isLoading else {
            return
        }
        fetchNewData()
    }
    
    func viewDidSelect(categoryIn indexPath: IndexPath) {
        if let category = self.state.feedCategories?[safe: indexPath.row] {
            output?.feedModuleIsRequestingCategoryModule(with: category)
        }
    }
    
    func viewDidPressLoginButton() {
        output?.feedModuleIsRequestingLoginModule()
    }
}

// MARK: -  FeedModuleInput

extension FeedPresenter: FeedModuleInput {
    
    func update(animated: Bool) {
        let viewModel = FeedViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
