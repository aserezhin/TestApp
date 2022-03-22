//
//  RegionCoordinator.swift
//  TestApp
//
//  Created by Алексей Серёжин on 22.03.2022.
//

import UIKit

class RegionCoordinator: Coordinatorable {

    typealias Output = Any

    // MARK: - Private properties

    private weak var nc: UINavigationController?

    // MARK: - Coordinatorable properties

    var output: ((Any) -> Void)?

    // MARK: - Initialization

    init(nc: UINavigationController?) {
        self.nc = nc
    }

    // MARK: - Coordinatorable

    func open() {
        self.showRegionList()
    }

    // MARK: - Private methods

    private func showRegionList() {
        let useCase = RegionUseCase()
        let viewModel = RegionListViewModel(regionUseCase: useCase)
        let vc = RegionListViewController(viewModel: viewModel)

        self.nc?.pushViewController(vc, animated: true)
        viewModel.start()
    }
}
