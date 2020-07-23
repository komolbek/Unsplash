//
//  Created by Komolbek Ibragimov on 20/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UICollectionViewCell

final class RegistrationCell: UICollectionViewCell {
    
    private(set) lazy var textFieldView: FormTextField = {
        let textFieldView: FormTextField = FormTextField()
        textFieldView.set(delegate: self)
        textFieldView.set(cornerRadius: 5)
        textFieldView.set(backgroundColor: .white)
        textFieldView.set(target: self, forSelector: #selector(handleTextFieldValueChange))
        return textFieldView
    }()
    
    var onTextChange: ((String?) -> Void)?
    var onKeyboardReturnPress: (() -> Void)? // finish
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(textFieldView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textFieldView.configureFrame {
            $0.right().top().left().bottom()
        }
    }

    @objc func handleTextFieldValueChange() {
        onTextChange?(textFieldView.text)
    }
}

//MARK: - UITextFieldDelegate

extension RegistrationCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        onKeyboardReturnPress?() // finish
        return true
    }
}
