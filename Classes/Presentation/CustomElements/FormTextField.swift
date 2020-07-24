//
//  Created by Komolbek Ibragimov on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIView

final class FormTextField: UIView {
    
    private enum Constants {
        static let height: CGFloat = 35
        static let spacing: CGFloat = 10
        static let insets: UIEdgeInsets = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        static let placeholderInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    }
    
    var text: String? {
        return textField.text
    }
    
    var isTextFieldResponder: Bool {
        switch textField.isFirstResponder {
        case true:
            return true
        case false:
            return false
        }
    }
    
    private let titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.courierWithSize_14
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField: UITextField = UITextField()
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.font = UIFont.courierWithSize_16
        textField.layer.backgroundColor = UIColor.green.cgColor
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(Constants.placeholderInsets.left, 0, 0);
        return textField
    }()
    
    private let errorLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.courierWithSize_12
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(titleLabel, textField, errorLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - TitleLabel
    
    func set(titleText text: String, withColor color: UIColor = .white) {
        titleLabel.text = text
        titleLabel.textColor = color
    }
    
    //MARK: - TextField
    
    func set(textFieldText text: String?) {
        textField.text = text
    }
    
    func set(delegate: UITextFieldDelegate) {
        textField.delegate = delegate
    }
    
    func set(placeholder value: String) {
        textField.placeholder = value
    }
    
    func set(keyboardType type: UIKeyboardType) {
        textField.keyboardType = type
    }
    
    func set(backgroundColor color: UIColor) {
        textField.backgroundColor = color
    }
    
    func set(cornerRadius value: CGFloat) {
        textField.layer.cornerRadius = value
    }
    
    func set(tag: Int) {
        textField.tag = tag
    }
    
    func set(isSecurityEntry: Bool) {
        textField.isSecureTextEntry = isSecurityEntry
    }
    
    func set(target object: Any?, forSelector selector: Selector) {
        textField.addTarget(object,
                            action: selector,
                            for: .allEditingEvents)
    }
    
    func setFirstResponder() {
        textField.becomeFirstResponder()
    }
    
    //MARK: - ErrorLabel
    
    func set(errorText text: String?, withColor color: UIColor = .white) {
        errorLabel.text = text
        errorLabel.textColor = color
        
        if text?.isEmpty ?? true {
//            setErrorState()
        } else {
//            setRegularState()
        }
    }
    
    private func setRegularState() {
        titleLabel.textColor = .white
        textField.layer.borderColor = UIColor.black.cgColor
    }
    
    private func setErrorState() {
        titleLabel.textColor = .red
        textField.layer.borderColor = UIColor.red.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.configureFrame {
            $0.left(to: textField.nui_left).top(inset: Constants.insets.top)
            $0.width(to: textField.nui_width).heightToFit()
        }
        textField.configureFrame {
            $0.centerX().top(to: titleLabel.nui_bottom, inset: Constants.spacing)
            $0.width(to: self.nui_width)
            $0.height(Constants.height)
        }
        errorLabel.configureFrame {
            $0.left(to: textField.nui_left).top(to: textField.nui_bottom, inset: Constants.spacing)
            $0.width(to: textField.nui_width).height(to: textField.nui_height, multiplier: 0.3)
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var fittingSize: CGSize = .init()
        fittingSize.height += titleLabel.sizeThatFits(size).height
        fittingSize.height += textField.sizeThatFits(size).height
        fittingSize.height += errorLabel.sizeThatFits(size).height
        fittingSize.height += Constants.height
        fittingSize.height += Constants.spacing * 2
        return fittingSize
    }
}
