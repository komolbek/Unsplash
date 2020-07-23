//
//  Created by Kamol Ibragimov on 07/07/2020
//  Copyright © 2020 HiQo. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    var output: CoordinatorOutput? { get set }
    func append(childCoordinator: CoordinatorProtocol)
    func remove(childCoordinator: CoordinatorProtocol)
}

protocol CoordinatorOutput: class {
    func childCoordinatorDidClose(_ childCoordinator: CoordinatorProtocol)
}

class Coordinator<ViewController: NavigationController>: NSObject, CoordinatorProtocol, CoordinatorOutput {

    let rootViewController: ViewController
    private(set) var childCoordinators: [CoordinatorProtocol] = []
    weak var output: CoordinatorOutput?

    var initialViewControllers: WeakArray<UIViewController>
    var presentationViewController: UIViewController?
    var isModal: Bool = false

    init(rootViewController: ViewController) {
        self.rootViewController = rootViewController
        self.initialViewControllers = WeakArray(rootViewController.viewControllers)

        super.init()
    }

    func startModally(from viewController: UIViewController? = nil, animated: Bool) {
        presentationViewController = viewController
        isModal = true
    }

    func start(animated: Bool) {
        fatalError("\(#function) should be overriden by \(String(describing: type(of: self))) subclass")
    }

    func close(animated: Bool) {
        reset(animated: animated)
    }

    private func reset(animated: Bool) {
        if isModal {
            presentationViewController?.dismiss(animated: animated, completion: nil)
            rootViewController.setViewControllers(initialViewControllers.strongified(), animated: animated)
        }
    }

    func append(childCoordinator: CoordinatorProtocol) {
        childCoordinator.output = self
        childCoordinators.append(childCoordinator)
    }

    func remove(childCoordinator: CoordinatorProtocol) {
        if let index = childCoordinators.firstIndex(where: { $0 === childCoordinator }) {
            childCoordinators.remove(at: index)
        }
    }

    // MARK: CoordinatorDelegate

    func childCoordinatorDidClose(_ childCoordinator: CoordinatorProtocol) {
        remove(childCoordinator: childCoordinator)
    }
}
