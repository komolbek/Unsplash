//
//  Created by Kamolbek on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol LoginViewInput: class {
    @discardableResult
    func update(with viewModel: LoginViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
    func handleError(_ error: LocalizedError, forType type: RegistrationField)
}

protocol LoginViewOutput: class {
    func viewDidLoad()
    func viewDidPressLoginButton()
    func viewDidPressCancelButton()
    func viewDidPressRegistrationButton()
    func viewDidChangeTextFieldValue(at index: Int, text: String?)
}

final class LoginViewController: UIViewController {
    
    private enum Constants {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        static let valueOf_44: CGFloat = 44
        static let valueOf_08: CGFloat = 0.8
    }
    
    private(set) var viewModel: LoginViewModel
    let output: LoginViewOutput
    
    var needsUpdate: Bool = true
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.nx_state = 0
        view.layer.cornerRadius = 10
        view.backgroundColor = .black
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var titleContainerView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var cancelButton: Button = {
        let button: Button = Button(type: .system)
        button.set(titleText: "Cancel")
        button.set(textAlignment: .left)
        button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Login"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.courierWithSize_18
        return label
    }()
    
    private let titleSeperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var usernameTextField: FormTextField = {
        let textFieldView: FormTextField = FormTextField()
        textFieldView.set(tag: 2)
        textFieldView.set(delegate: self)
        textFieldView.set(cornerRadius: 5)
        textFieldView.set(titleText: "Name")
        textFieldView.set(backgroundColor: .white)
        textFieldView.set(placeholder: "Username")
        textFieldView.set(target: self, forSelector: #selector(handleTextFieldValue))
        return textFieldView
    }()
    
    private lazy var passwordTextField: FormTextField = {
        let textFieldView: FormTextField = FormTextField()
        textFieldView.set(tag: 4)
        textFieldView.set(delegate: self)
        textFieldView.set(cornerRadius: 5)
        textFieldView.set(titleText: "Password")
        textFieldView.set(isSecurityEntry: true)
        textFieldView.set(backgroundColor: .white)
        textFieldView.set(placeholder: "Password")
        textFieldView.set(target: self, forSelector: #selector(handleTextFieldValue))
        return textFieldView
    }()
    
    private let passwordSeperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var loginButton: Button = {
        let button: Button = Button(type: .system)
        button.set(backgroundColor: .white)
        button.set(titleText: "Log in", with: .black)
        button.set(terget: self, forSelector: #selector(handleLogInButton))
        return button
    }()
    
    private lazy var registionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.text = "Don't have an account?"
        label.font = UIFont.courierWithSize_16
        return label
    }()
    
    private let registrationButton: UIButton = {
        let button = Button(type: .system)
        button.set(textAlignment: .left)
        button.set(titleText: "Join", with: .white)
        button.set(font: UIFont.courierWithBoldSize_18)
        button.set(terget: self, forSelector: #selector(handleRegistrationButton))
        return button
    }()
    
    // MARK: -  Lifecycle
    
    init(viewModel: LoginViewModel, output: LoginViewOutput) {
        self.viewModel = viewModel
        self.output = output
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidLoad()
        
        titleContainerView.addSubviews(titleLabel, cancelButton)
        containerView.addSubviews(titleContainerView,
                                  titleSeperatorView,
                                  usernameTextField,
                                  passwordTextField,
                                  passwordSeperatorView,
                                  loginButton,
                                  registionLabel,
                                  registrationButton)
        view.addSubview(containerView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        containerView.configureFrame(state: 0) {
            $0.center().width(to: view.nui_width, multiplier: 0.9)
            $0.height(to: view.nui_height, multiplier: 0.65)
        }
        containerView.configureFrame(state: 1) {
            $0.top(to: view.nui_top)
        }
        titleContainerView.configureFrame {
            $0.top().left().right()
            $0.height(Constants.valueOf_44)
        }
        titleSeperatorView.configureFrame {
            $0.top(to: titleContainerView.nui_bottom)
            $0.centerX().height(1).width(to: view.nui_width)
        }
        titleLabel.configureFrame {
            $0.center().height(to: titleContainerView.nui_height)
            $0.width(to: containerView.nui_width, multiplier: 0.3)
        }
        cancelButton.configureFrame {
            $0.left().centerY().right(to: titleLabel.nui_left)
            $0.height(to: titleContainerView.nui_height)
        }
        usernameTextField.configureFrame {
            $0.centerX().top(to: titleLabel.nui_bottom, inset: Constants.insets.top)
            $0.width(to: containerView.nui_width, multiplier: Constants.valueOf_08).heightToFit()
        }
        passwordTextField.configureFrame {
            $0.centerX().top(to: usernameTextField.nui_bottom)
            $0.width(to: containerView.nui_width, multiplier: Constants.valueOf_08).heightToFit()
        }
        passwordSeperatorView.configureFrame {
            $0.top(to: passwordTextField.nui_bottom)
            $0.centerX().height(1).width(to: passwordTextField.nui_width)
        }
        loginButton.configureFrame {
            $0.top(to: passwordSeperatorView.nui_bottom, inset: Constants.insets.top)
            $0.centerX().height(Constants.valueOf_44)
            $0.width(to: containerView.nui_width, multiplier: Constants.valueOf_08)
        }
        registionLabel.configureFrame {
            $0.bottom(to: containerView.nui_bottom, inset: Constants.insets.bottom * 2)
            $0.left(to: containerView.nui_left, inset: Constants.insets.left * 2.5)
            $0.heightToFit().widthToFit()
        }
        registrationButton.configureFrame {
            $0.left(to: registionLabel.nui_right, inset: Constants.insets.left).top(to: registionLabel.nui_top)
            $0.height(to: registionLabel.nui_height).widthToFit()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: -  Actions
    
    @objc private func handleCancelButton() {
        output.viewDidPressCancelButton()
    }
    
    @objc private func handleLogInButton() {
        output.viewDidPressLoginButton()
    }
    
    @objc private func handleRegistrationButton() {
        view.endEditing(true)
        output.viewDidPressRegistrationButton()
    }
    
    @objc private func handleTextFieldValue(_ textField: UITextField) {
        output.viewDidChangeTextFieldValue(at: textField.tag, text: textField.text)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        animate(view: containerView, toState: 1)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        animate(view: containerView, toState: 0)
    }
    
    //MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
}

// MARK: -  LoginViewInput

extension LoginViewController: LoginViewInput, ViewUpdatable {
    
    func setNeedsUpdate() {
        needsUpdate = true
    }
    
    func handleError(_ error: LocalizedError, forType type: RegistrationField) {
        switch type {
        case .userName:
            usernameTextField.set(errorText: error.localizedDescription, withColor: .red)
        case .password:
            passwordTextField.set(errorText: error.localizedDescription, withColor: .red)
        default:
            break
        }
    }
    
    @discardableResult
    func update(with viewModel: LoginViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel
        
        needsUpdate = false
        
        return true
    }
}

//MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if usernameTextField.isTextFieldResponder {
            passwordTextField.setFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
}
