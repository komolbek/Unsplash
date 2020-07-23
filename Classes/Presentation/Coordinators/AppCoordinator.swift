//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator<NavigationController> {

    typealias Dependencies = Any

    private let dependencies: Dependencies

    // MARK: - Lifecycle

    init(rootViewController: NavigationController? = nil, dependencies: Dependencies = [Any]()) {
        let rootViewController = rootViewController ?? NavigationController()
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController)
    }

    func start(launchOptions: LaunchOptions?) {
        let module = FeedModule()
        module.output = self
        rootViewController.setViewControllers([module.viewController], animated: true)
    }
    
    private func pushCategoryDetailModule(with category: FeedCategory) {
        let categoryDetailState = CategoryDetailState(category: category)
        let module = CategoryDetailModule(with: categoryDetailState)
        rootViewController.pushViewController(module.viewController, animated: true)
    }
    
    private func presentLoginModule() {
        let loginCoordinator: AuthentificationCoordinator = .init()
        append(childCoordinator: loginCoordinator)
        rootViewController.present(loginCoordinator.navRootViewController, animated: true, completion: nil)
    }
}

//MARK: - FeedModuleOutput

extension AppCoordinator: FeedModuleOutput {
    
    func feedModuleDidClose(_ moduleInput: FeedModuleInput) {
        
    }
    
    func feedModuleIsRequestingCategoryModule(with category: FeedCategory) {
        pushCategoryDetailModule(with: category)
    }
    
    func feedModuleIsRequestingLoginModule() {
        presentLoginModule()
    }
}
