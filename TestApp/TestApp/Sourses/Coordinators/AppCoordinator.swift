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

    private var regionCoordinator: RegionCoordinator?

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
        let ncRegion = UINavigationController()
        tabBarController.viewControllers = [ncRegion]

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()

        self.showRegionFlow(nc: ncRegion)
    }

    // MARK: - Private methods

    private func showRegionFlow(nc: UINavigationController) {
        self.regionCoordinator = RegionCoordinator(nc: nc)
        self.regionCoordinator?.open()
    }
}
