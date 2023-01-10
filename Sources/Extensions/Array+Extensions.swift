//
//  Array+Extensions.swift
//  SettingsBundle_Sample
//
//  Created by Osman Yıldırım
//

import Foundation

extension Array {
    func item<Value: Comparable>(keyPath: KeyPath<Element, Value>, equals: Value) -> Element? {
        first { $0[keyPath: keyPath] == equals }
    }
}
