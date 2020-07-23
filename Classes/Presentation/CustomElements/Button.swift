//
//  Created by Komolbek Ibragimov on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIButton

final class Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 5
        backgroundColor = .clear
        titleLabel?.textAlignment = .center
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.courierWithSize_18
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(font: UIFont?) {
        titleLabel?.font = font
    }
    
    func set(terget object: Any?, forSelector selector: Selector) {
        addTarget(object, action: selector, for: .touchUpInside)
    }
    
    func set(titleText text: String, with textColor: UIColor = .white) {
        setTitle(text, for: .normal)
        setTitleColor(textColor, for: .normal)
    }
    
    func set(textAlignment value: NSTextAlignment) {
        titleLabel?.textAlignment = value
    }
    
    func set(backgroundColor color: UIColor) {
        backgroundColor = color
    }
}




