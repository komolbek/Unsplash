//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

typealias LaunchOptions = [UIApplication.LaunchOptionsKey: Any]

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private lazy var appCoordinator: AppCoordinator = .init()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: LaunchOptions?) -> Bool {
        AppConfigurator.configure(application, with: launchOptions)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = appCoordinator.rootViewController
        window?.makeKeyAndVisible()

        // пока только так. кастомный попробывал, не смог до конца понять, если что потом покажу
        let image = UIImage.CategoryDetail.navLeftButtonImage
        appCoordinator.rootViewController.navigationBar.backIndicatorImage = image
        appCoordinator.rootViewController.navigationBar.backIndicatorTransitionMaskImage = image
        appCoordinator.rootViewController.navigationBar.tintColor = .white
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -40.0), for: .default)
            
        appCoordinator.start(launchOptions: launchOptions)

        return true
    }
}
