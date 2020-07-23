//
//  Created by Kamolbek on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

final class LoginPresenter {
    
    typealias Dependencies = Any
    
    weak var view: LoginViewInput?
    weak var output: LoginModuleOutput?
    
    var state: LoginState
    
    private let dependencies: Dependencies
    
    private lazy var user: RegistrationUser = .init()
    
    init(state: LoginState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    private func authUser() {
        RegistrationField.allCases.forEach { fieldType in
            checkTextFieldInput(for: fieldType)
        }
        print("passed")
        //authService
    }
    
    private func checkTextFieldInput(for fieldType: RegistrationField) {
        do {
            try validateInputText(with: fieldType)
        } catch {
            if let error = error as? RequiredFieldError {
                view?.handleError(error, forType: fieldType)
            } else if let error = error as? RequiredPasswordError {
                view?.handleError(error, forType: fieldType)
            }
        }
    }
    
    private func validateInputText(with fieldType: RegistrationField) throws {
        switch fieldType {
        case .userName:
            try RequiredTextFieldValidator(name: fieldType).validateText(user.userName)
        case .password:
            try RequiredPasswordValidator(name: fieldType).validate(password: user.password)
        default:
            break
        }
    }
}

// MARK: -  LoginViewOutput

extension LoginPresenter: LoginViewOutput {
    
    func viewDidLoad() {
        update(animated: false)
    }
    
    func viewDidPressCancelButton() {
        output?.loginModuleDidRequestDismiss()
    }
    
    func viewDidPressLoginButton() {
        authUser()
    }
    
    func viewDidChangeTextFieldValue(at index: Int, text: String?) {
        guard let inputType = RegistrationField.allCases[safe: index] else {
            return
        }
        
        switch inputType {
        case .userName:
            user.userName = text
        case .password:
            user.password = text
        default:
            break
        }
    }
    
    func viewDidPressRegistrationButton() {
        output?.loginModuleDidRequestRegisterModule()
    }
}

// MARK: -  LoginModuleInput

extension LoginPresenter: LoginModuleInput {
    
    func update(animated: Bool) {
        let viewModel = LoginViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}


