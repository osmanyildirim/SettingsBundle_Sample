//
//  MainViewModel.swift
//  SettingsBundle_Sample
//
//  Created by Osman Yıldırım
//

import Foundation

final class MainViewModel: BaseViewModel {

    weak var delegate: ViewModelHandler?

    private var pokemons = [Pokemon]()

    func fetchData() {
        pokemons = Bundle.main.decode(file: "source", fileType: "json", type: [Pokemon].self) ?? []
    }

    func getSelectedPokemon() {
        guard let selected = UserDefaults.standard.string(forKey: "pokemon"), let pokemon = pokemons.item(keyPath: \.name!, equals: selected) else {
            handleEvent(.passData(pokemons.first!))
            return
        }
        handleEvent(.passData(pokemon))
    }
}
