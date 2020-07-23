//
//  Created by Kamolbek on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol RegistrationViewInput: class {
    @discardableResult
    func update(with viewModel: RegistrationViewModel, animated: Bool) -> Bool
    func setNeedsUpdate()
}

protocol RegistrationViewOutput: class {
    func viewDidLoad()
    func viewDidPressBackButton()
    func viewDidChangeTextFieldValue(_ indexPath: IndexPath, text: String?)
    func viewDidPressRegistrationButton()
}

final class RegistrationViewController: UIViewController {
    
    private enum Constants {
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        static let valueOf_40: CGFloat = 40
    }
    
    private(set) var viewModel: RegistrationViewModel
    let output: RegistrationViewOutput
    
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
    
    private lazy var titleSeperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var cancelButton: Button = {
        let button: Button = Button(type: .system)
        button.set(titleText: "Back")
        button.set(textAlignment: .left)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.text = "Registration"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.courierWithSize_18
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerCellClass(RegistrationCell.self)
        return collectionView
    }()
    
    private lazy var collectionSeperatorView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var registationButton: Button = {
        let button: Button = Button(type: .system)
        button.set(backgroundColor: .white)
        button.set(titleText: "Sign up", with: .black)
        button.addTarget(self, action: #selector(handleRegistrationButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: -  Lifecycle
    
    init(viewModel: RegistrationViewModel, output: RegistrationViewOutput) {
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
                                  collectionView,
                                  collectionSeperatorView,
                                  registationButton)
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.configureFrame(state: 0) {
            $0.center()
            $0.width(to: view.nui_width, multiplier: 0.9)
            $0.height(to: view.nui_height, multiplier: 0.9)
        }
        containerView.configureFrame(state: 1) {
            $0.top(to: view.nui_top, inset: -Constants.insets.top * 3)
        }
        titleContainerView.configureFrame {
            $0.top().left().right()
            $0.height(Constants.valueOf_40 + 4)
        }
        titleSeperatorView.configureFrame {
            $0.top(to: titleContainerView.nui_bottom)
            $0.centerX().height(1).width(to: view.nui_width)
        }
        titleLabel.configureFrame {
            $0.centerX().centerY()
            $0.height(to: titleContainerView.nui_height)
            $0.widthToFit()
        }
        cancelButton.configureFrame {
            $0.left().centerY().right(to: titleLabel.nui_left)
            $0.height(to: titleContainerView.nui_height)
        }
        collectionView.configureFrame {
            $0.top(to: titleSeperatorView.nui_bottom)
            $0.left(to: containerView.nui_left).right(to: containerView.nui_right).height(to: containerView.nui_height, multiplier: 0.8)
        }
        collectionSeperatorView.configureFrame {
            $0.top(to: collectionView.nui_bottom)
            $0.centerX().height(1).width(to: collectionView.nui_width)
        }
        registationButton.configureFrame {
            $0.bottom(to: containerView.nui_bottom, inset: Constants.insets.bottom)
            $0.centerX().height(Constants.valueOf_40)
            $0.width(to: containerView.nui_width, multiplier: 0.8)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: -  Actions
    
    @objc private func handleBackButton() {
        output.viewDidPressBackButton()
    }
    
    @objc private func handleRegistrationButton() {
        output.viewDidPressRegistrationButton()
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        animate(view: containerView, toState: 1)
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        animate(view: containerView, toState: 0)
    }
    
    //MARK: -  Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
    }
}

// MARK: -  RegistrationViewInput

extension RegistrationViewController: RegistrationViewInput, ViewUpdatable {
    
    func setNeedsUpdate() {
        needsUpdate = true
    }
    
    @discardableResult
    func update(with viewModel: RegistrationViewModel, animated: Bool) -> Bool {
        let oldViewModel = self.viewModel
        guard needsUpdate || viewModel != oldViewModel else {
            return false
        }
        self.viewModel = viewModel
        
        needsUpdate = false
        
        update(new: viewModel, old: oldViewModel, keyPath: \.cellModels) { _ in
            collectionView.reloadData()
        }
        
        return true
    }
}

// MARK: -  UICollectionViewDataSource

extension RegistrationViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cellModel = viewModel.cellModels[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        let cell: RegistrationCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.textFieldView.set(titleText: cellModel.title)
        cell.textFieldView.set(tag: indexPath.row)
        cell.textFieldView.set(placeholder: cellModel.title)
        cell.textFieldView.set(textFieldText: cellModel.text)
        cell.textFieldView.set(errorText: cellModel.error, withColor: .red)
        cell.onTextChange = { [weak self] text in
            self?.output.viewDidChangeTextFieldValue(indexPath, text: text)
        }
        return cell
    }
}

// MARK: -  UICollectionViewDelegateFlowLayout

extension RegistrationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width * 0.9, // sizeThatFits
                      height: collectionView.bounds.height * 0.18)
    }
}

