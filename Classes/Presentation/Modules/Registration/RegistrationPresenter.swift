//
//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import Foundation

final class RegistrationPresenter {

    typealias Dependencies = HasAuthService

    weak var view: RegistrationViewInput?
    weak var output: RegistrationModuleOutput?

    var state: RegistrationState

    private let dependencies: Dependencies
    
    private lazy var user: RegistrationUser = .init()

    init(state: RegistrationState, dependencies: Dependencies) {
        self.state = state
        self.dependencies = dependencies
    }
    
    private func registerUser() {
        RegistrationField.allCases.forEach { fieldType in
            checkTextFieldInput(for: fieldType)
        }
        
        guard state.errors.isEmpty else {
            update(animated: true)
            return
        }
        
        dependencies.authService.registerUser(user: user)
    }
    
    private func checkTextFieldInput(for fieldType: RegistrationField) {
        do {
            try validateInputText(with: fieldType)
        } catch {
            if let error = error as? RequiredFieldError {
                if let index = RegistrationField.allCases.firstIndex(of: fieldType) {
                    state.errors[IndexPath(row: index, section: 0)] = error.errorDescriptionText
                }
            } else if let error = error as? RequiredEmailError {
                if let index = RegistrationField.allCases.firstIndex(of: fieldType) {
                    state.errors[IndexPath(row: index, section: 0)] = error.errorDescriptionText
                }
            } else if let error = error as? RequiredPasswordError {
                if let index = RegistrationField.allCases.firstIndex(of: fieldType) {
                    state.errors[IndexPath(row: index, section: 0)] = error.errorDescriptionText
                }
            }
        }
    }
    
    private func validateInputText(with fieldType: RegistrationField) throws {
        switch fieldType {
        case .firstName:
            try RequiredTextFieldValidator(name: fieldType).validateText(user.firstName)
        case .lastName:
            try RequiredTextFieldValidator(name: fieldType).validateText(user.lastName)
        case .userName:
            try RequiredTextFieldValidator(name: fieldType).validateText(user.userName)
        case .email:
            try RequiredEmailValidator(name: fieldType).validate(email: user.email)
        case .password:
            try RequiredPasswordValidator(name: fieldType).validate(password: user.password)
        }
    }
}

// MARK: -  RegistrationViewOutput

extension RegistrationPresenter: RegistrationViewOutput {
    
    func viewDidLoad() {
        update(animated: false)
    }
    
    func viewDidPressBackButton() {
        output?.registrationModuleDidRequestLoginModule()
    }
    
    func viewDidPressRegistrationButton() {
        state.errors = [:]
        registerUser()
    }
    
    func viewDidChangeTextFieldValue(_ indexPath: IndexPath, text: String?) {
        guard let inputType = RegistrationField.allCases[safe: indexPath.row],
        let text = text else {
            return
        }
        
        if let index = RegistrationField.allCases.firstIndex(of: inputType),
            !(state.errors[IndexPath(row: index, section: 0)]?.isEmpty ?? false) {
             state.errors[IndexPath(row: index, section: 0)] = ""
            update(animated: true)
        }
        
        if let index = RegistrationField.allCases.firstIndex(of: inputType) {
            state.texts[IndexPath(row: index, section: 0)] = text
        }
        
        switch inputType {
        case .firstName:
            user.firstName = text
        case .lastName:
            user.lastName = text
        case .userName:
            user.userName = text
        case .email:
            user.email = text
        case .password:
            user.password = text
        }
    }
}

// MARK: -  RegistrationModuleInput

extension RegistrationPresenter: RegistrationModuleInput {

    func update(animated: Bool) {
        let viewModel = RegistrationViewModel(state: state)
        view?.update(with: viewModel, animated: animated)
    }
}
