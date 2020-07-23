//
//  Created by Komolbek Ibragimov on 22/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UIViewController

extension UIViewController {
    
    func animate(view: UIView, toState state: Int) {
        self.view.setNeedsLayout()
        view.nx_state = state
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
