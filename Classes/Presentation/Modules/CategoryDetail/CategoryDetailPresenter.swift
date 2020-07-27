//
//  Created by Kamolbek on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class CategoryDetailPresenter {

    typealias Dependencies = HasPhotoService

    weak var view: CategoryDetailViewInput?
    weak var output: CategoryDetailModuleOutput?

    var state: CategoryDetailState

    private let dependencies: Dependencies

    init(state: CategoryDetailState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    private func fetchData() {
        state.isLoading = true
        self.update(animated: false)

        dependencies.photoService.fetchCategoryDetails(title: state.category.title,
                                                       categoryID: state.category.id,
                                                       success: { [weak self] categoryDetails in

            if let categoryDetails = categoryDetails, let self = self {
                self.state.images = categoryDetails.results
                self.state.isLoading = false
                self.update(animated: false)
            }
        }) { error in
            print(error.localizedDescription)
        }
    }
}

// MARK: -  CategoryDetailViewOutput

extension CategoryDetailPresenter: CategoryDetailViewOutput {

    func viewDidLoad() {
        fetchData()
    }
}

// MARK: -  CategoryDetailModuleInput

extension CategoryDetailPresenter: CategoryDetailModuleInput {

    func update(animated: Bool) {
        DispatchQueue.main.async {
            let viewModel = CategoryDetailViewModel(state: self.state)
            self.view?.update(with: viewModel, animated: animated)
        }
    }
}
