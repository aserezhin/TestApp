//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import UIKit

class AppCoordinator: Coordinatorable {

    typealias Output = Any

    // MARK: - Private properties

    private weak var window: UIWindow?

    // MARK: - Coordinatorable properties

    var output: ((Any) -> Void)?

    // MARK: - Initialization

    init(window: UIWindow?) {
        self.window = window
    }

    // MARK: - Coordinatorable

    func open() {
        guard let window = self.window else {
            return
        }

        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [UIViewController(), UIViewController(), UIViewController()]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }

    // MARK: - Private methods

}
