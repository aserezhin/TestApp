//
//  RegionListViewModel.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import Foundation
import Combine

final class RegionListViewModel: IRegionListViewModel {


    // MARK: - Private properties

    @Published private var state: RegionListState = .regions([])
    private let regionUseCase: RegionUseCase
    private var bin: Set<AnyCancellable> = []

    // MARK: - IRegionListViewModel

    lazy var statePublisher: AnyPublisher<RegionListState, Never> = self.$state.eraseToAnyPublisher()
    var output: RegionListViewModelOutput?

    init(regionUseCase: RegionUseCase, output: RegionListViewModelOutput? = nil) {
        self.regionUseCase = regionUseCase
        self.output = output
    }

    // MARK: - IRegionListViewModel

    func bind(selections: AnyPublisher<Int, Never>) {
        selections.sink { [weak self] index in
            guard let self = self else {
                return
            }
            guard case let .regions(values) = self.state else {
                return
            }

            self.regionUseCase.select(region: values[safe: index])
            self.output?(.regionSelected)
        }
        .store(in: &bin)
    }

    // MARK: - Public methods

    func start() {
        self.bin.forEach { $0.cancel() }
        self.regionUseCase.getRegions()
            .map { regions in
                regions.map { $0.rawValue }
            }
            .map { .regions($0) }
            .sink { [weak self] state in
                self?.state = state
            }
            .store(in: &bin)
    }
}
