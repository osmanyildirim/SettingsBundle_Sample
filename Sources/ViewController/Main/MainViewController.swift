//
//  MainViewController.swift
//  SettingsBundle_Sample
//
//  Created by Osman Yıldırım
//

import UIKit
import SnapKit
import UIImageColors

final class MainViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.cornerRadius(radius: 10)
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
        return label
    }()

    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var heightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(spaceView)
        stackView.addArrangedSubview(typeLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(weightLabel)
        return stackView
    }()

    private lazy var spaceView: UIView = {
        let view = UIView()
        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.addSubview(imageView)
        view.addSubview(stackView)
        return view
    }()

    private lazy var changeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Pokemon", for: .normal)
        button.cornerRadius(radius: 5)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(self.change), for: .touchUpInside)
        return button
    }()

    var viewModel: BaseViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.alpha = 0
        setupViews()
        setupLayout()

        viewModel?.delegate = self
        viewModel?.fetchData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reload), name: Notification.Name("ReloadPokemon"), object: nil)
    }

    func setupViews() {
        view.addSubview(containerView)
        view.addSubview(changeButton)
    }

    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(imageView.snp.height).multipliedBy(1)
        }

        stackView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(30)
        }

        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }

        spaceView.snp.makeConstraints { make in
            make.height.equalTo(5)
        }

        changeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
}

extension MainViewController {
    private func setData(_ pokemon: Pokemon) {
        imageView.image = pokemon.image
        titleLabel.text = pokemon.name!

        let colors = pokemon.image?.getColors(quality: .high)
        view.backgroundColor = colors?.background
        changeButton.backgroundColor = colors?.secondary
        titleLabel.textColor = colors?.detail
        [typeLabel, heightLabel, weightLabel].forEach({ $0.textColor = colors?.primary })

        let typeAttr = NSMutableAttributedString(string: "Type: ")
        let typeTitleAttr = NSMutableAttributedString(string: pokemon.type ?? "", attributes: [NSAttributedString.Key.foregroundColor: colors?.secondary ?? .white])
        typeAttr.append(typeTitleAttr)

        typeLabel.attributedText = typeAttr

        let heightAttr = NSMutableAttributedString(string: "Height: ")
        let heightTitleAttr = NSMutableAttributedString(string: pokemon.height ?? "", attributes: [NSAttributedString.Key.foregroundColor: colors?.secondary ?? .white])
        heightAttr.append(heightTitleAttr)

        heightLabel.attributedText = heightAttr

        let weightAttr = NSMutableAttributedString(string: "Weight: ")
        let weightTitleAttr = NSMutableAttributedString(string: pokemon.weight ?? "", attributes: [NSAttributedString.Key.foregroundColor: colors?.secondary ?? .white])
        weightAttr.append(weightTitleAttr)

        weightLabel.attributedText = weightAttr

        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1
        }
    }

    @objc private func reload() {
        (viewModel as? MainViewModel)?.getSelectedPokemon()
    }

    @objc private func change() {
        UIApplication.openAppSettings()
    }
}

extension MainViewController: ViewModelHandler {
    func eventHandler(_ event: BaseEvents) {
        switch event {
        case .passData(let pokemon):
            setData(pokemon)
        }
    }
}
