//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator<UINavigationController> {

    typealias Dependencies = Any

    private let dependencies: Dependencies

    // MARK: - Lifecycle

    init(rootViewController: UINavigationController? = nil, dependencies: Dependencies = [Any]()) {
        let rootViewController = rootViewController ?? UINavigationController()
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController)
    }

    func start(launchOptions: LaunchOptions?) {
        let module = FeedModule()
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: true)
    }
    
    func pushCategoryDetailModule(with category: FeedCategory) {
        let categoryDetailState = CategoryDetailState(category: category)
        let module = CategoryDetailModule(with: categoryDetailState)
        rootViewController.pushViewController(module.viewController, animated: true)
    }
}

extension AppCoordinator: FeedModuleOutput {
    
    func feedModuleDidClose(_ moduleInput: FeedModuleInput) {
        
    }
    
    func feedModuleIsRequestingCategoryDetailModule(with category: FeedCategory) {
        pushCategoryDetailModule(with: category)
    }
}
