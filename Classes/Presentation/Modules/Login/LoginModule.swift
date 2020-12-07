//
//  Created by Kamolbek on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol LoginModuleInput: class {
    var state: LoginState { get }
    func update(animated: Bool)
}

protocol LoginModuleOutput: class {
    func loginModuleDidClose(_ moduleInput: LoginModuleInput)
    func loginModuleDidRequestDismiss()
    func loginModuleDidRequestRegisterModule()
}

final class LoginModule {

    var input: LoginModuleInput {
        return presenter
    }
    weak var output: LoginModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: LoginViewController
    private let presenter: LoginPresenter

    init() {
        let state = LoginState()
        let viewModel = LoginViewModel(state: state)
        let presenter = LoginPresenter(state: state, dependencies: ServiceContainer())
        let viewController = LoginViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
