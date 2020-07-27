//
//  Created by Kamolbek on 13/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol CategoryDetailModuleInput: class {
    var state: CategoryDetailState { get }
    func update(animated: Bool)
}

protocol CategoryDetailModuleOutput: class {
    func categoryDetailModuleDidClose(_ moduleInput: CategoryDetailModuleInput)
}

final class CategoryDetailModule {

    var input: CategoryDetailModuleInput {
        return presenter
    }
    weak var output: CategoryDetailModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: CategoryDetailViewController
    private let presenter: CategoryDetailPresenter

    init(with state: CategoryDetailState) {
        let viewModel = CategoryDetailViewModel(state: state)
        let presenter = CategoryDetailPresenter(state: state, dependencies: ServiceContainer())
        let viewController = CategoryDetailViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
