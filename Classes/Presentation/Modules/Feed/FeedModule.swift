//
//  Created by Kamolbek on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol FeedModuleInput: class {
    var state: FeedState { get }
    func update(animated: Bool)
}

protocol FeedModuleOutput: class {
    func feedModuleDidClose(_ moduleInput: FeedModuleInput)
    func feedModuleIsRequestingCategoryModule(with category: FeedCategory)
    func feedModuleIsRequestingLoginModule()
}

final class FeedModule {

    var input: FeedModuleInput {
        return presenter
    }
    var output: FeedModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: FeedViewController
    private let presenter: FeedPresenter

    init() {
        let state = FeedState()
        let viewModel = FeedViewModel(state: state)
        let presenter = FeedPresenter(state: state, dependencies: ServiceContainer())
        let viewController = FeedViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
