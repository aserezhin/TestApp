//
//  Coordinatorable.swift
//  TestApp
//
//  Created by Алексей Серёжин on 21.03.2022.
//

import Foundation

protocol Coordinatorable: AnyObject {
    associatedtype Output

    var output: ((Output) -> Void)? { get set }

    func open()
}
