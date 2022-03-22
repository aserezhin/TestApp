//
//  IListViewModel.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import Foundation
import Combine

protocol IRegionListViewModel {
    var statePublisher: AnyPublisher<RegionListState, Never> { get }
    func bind(selections: AnyPublisher<Int, Never>)
}
