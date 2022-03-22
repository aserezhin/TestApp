//
//  RegionUseCase.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import Foundation
import Combine

class RegionUseCase {

    @Published var selected: Region? = nil

    func getRegions() -> AnyPublisher<[Region], Never> {
        return CurrentValueSubject(Region.allCases).eraseToAnyPublisher()
    }

    func select(region: String?) {
        self.selected = Region.init(rawValue: region ?? "")
    }

}
