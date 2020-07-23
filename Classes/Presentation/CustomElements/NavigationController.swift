//
//  Created by Komolbek Ibragimov on 16/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit.UINavigationController

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barStyle = .black
        navigationBar.tintColor = .black
        navigationBar.tintColor = .white
        navigationItem.backBarButtonItem?.title = nil
        navigationItem.backBarButtonItem?.image = Asset.CategoryDetailFeedModule.backIcon.image
    }
}
