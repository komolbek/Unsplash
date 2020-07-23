//
//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol RegistrationModuleInput: class {
    var state: RegistrationState { get }
    func update(animated: Bool)
}

protocol RegistrationModuleOutput: class {
    func registrationModuleDidClose(_ moduleInput: RegistrationModuleInput)
    func registrationModuleDidRequestLoginModule()
    func registrationModuleDidRequestFeedModule()
}

final class RegistrationModule {

    var input: RegistrationModuleInput {
        return presenter
    }
    weak var output: RegistrationModuleOutput? {
        get {
            return presenter.output
        }
        set {
            presenter.output = newValue
        }
    }
    let viewController: RegistrationViewController
    private let presenter: RegistrationPresenter

    init() {
        let state = RegistrationState()
        let viewModel = RegistrationViewModel(state: state)
        let presenter = RegistrationPresenter(state: state, dependencies: ServiceContainer())
        let viewController = RegistrationViewController(viewModel: viewModel, output: presenter)
        
        presenter.view = viewController
        self.viewController = viewController
        self.presenter = presenter
    }
}
