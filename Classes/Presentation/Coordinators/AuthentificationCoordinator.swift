//
//  Created by Kamolbek on 21/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol AuthentificationCoordinatorOutput: CoordinatorOutput {}

final class AuthentificationCoordinator: Coordinator<NavigationController> {
    
    typealias Dependencies = Any
    
    private let dependencies: Dependencies
    
    let navRootViewController = NavigationController()
    
    // MARK: -  Lifecycle
    
    init(rootViewController: NavigationController? = nil, dependencies: Dependencies = [Any]()) {
        self.dependencies = dependencies
        super.init(rootViewController: rootViewController ?? NavigationController())
        start(animated: true)
    }
    
    override func start(animated: Bool) {
        let module = LoginModule()
        module.output = self
        navRootViewController.navigationBar.isHidden = true
        navRootViewController.viewControllers = [module.viewController]
    }
    
    private func dismissLoginModule() {
        navRootViewController.dismiss(animated: true, completion: nil)
    }
    
    private func pushRegistrationModule() {
        let module = RegistrationModule()
        module.output = self
        navRootViewController.pushViewController(module.viewController, animated: true)
    }
    
    private func popToLoginModule() {
        navRootViewController.popViewController(animated: true)
    }
}

//MARK: - RegistrationModuleOutput

extension AuthentificationCoordinator: RegistrationModuleOutput {
    
    func registrationModuleDidClose(_ moduleInput: RegistrationModuleInput) {
        
    }
    
    func registrationModuleDidRequestLoginModule() {
        popToLoginModule()
    }
    
    func registrationModuleDidRequestFeedModule() {
        dismissLoginModule()
    }
}

//MARK: - LoginModuleOutput

extension AuthentificationCoordinator: LoginModuleOutput {
    
    func loginModuleDidClose(_ moduleInput: LoginModuleInput) {
        
    }
    
    func loginModuleDidRequestDismiss() {
        dismissLoginModule()
    }
    
    func loginModuleDidRequestRegisterModule() {
        pushRegistrationModule()
    }
}
