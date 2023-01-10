//
//  Pokemon.swift
//  SettingsBundle_Sample
//
//  Created by Osman Yıldırım
//

import UIKit

struct Pokemon: Decodable, Hashable {
    var name: String?
    var type: String?
    var height: String?
    var weight: String?
    var image: UIImage? {
        guard let name = name else { return nil }
        return UIImage(named: name.lowercased())
    }
}
