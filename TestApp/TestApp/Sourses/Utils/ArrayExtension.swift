//
//  ArrayExtension.swift
//  TestApp
//
//  Created by Алексей Серёжин on 22.03.2022.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
