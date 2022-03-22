//
//  RegionListViewModelOutput.swift
//  TestApp
//
//  Created by Алексей Серёжин on 22.03.2022.
//

import Foundation

typealias RegionListViewModelOutput = (RegionListOut) -> Void

enum RegionListOut {
    case regionSelected
}
