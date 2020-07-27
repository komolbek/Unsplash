//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit


final class AppConfigurator {

    static func configure(_ application: UIApplication, with launchOptions: LaunchOptions?) {
        let appVersion = "\(Bundle.main.appVersion) (\(Bundle.main.bundleVersion))"
        UserDefaults.standard.appVersion = appVersion
    }
}

private extension UserDefaults {

    var appVersion: String? {
        get {
            return string(forKey: #function)
        }
        set {
            set(newValue, forKey: #function)
        }
    }
}
