//
//  CountryDetailViewController.swift
//  Lesson14
//
//  Created by Daria Nikitina on 19.12.2024.
//

import UIKit

class CountryDetailViewController: UIViewController {
    
    var country: Country? {
        didSet {
            updateUI()
        }
    }
    
    private let nameLabel = UILabel()
    private let capitalLabel = UILabel()
    private let populationLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel, capitalLabel, populationLabel, descriptionLabel].forEach { label in
            label.numberOfLines = 0
            stackView.addArrangedSubview(label)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
        
        updateUI()
    }
    
    private func updateUI() {
        guard isViewLoaded else { return }
        guard let country = country else {
            title = "Выберите страну"
            nameLabel.text = ""
            capitalLabel.text = ""
            populationLabel.text = ""
            descriptionLabel.text = "Выберите страну из списка слева"
            return
        }
        
        title = country.name
        nameLabel.text = "Страна: \(country.name)"
        capitalLabel.text = "Столица: \(country.capital)"
        populationLabel.text = "Население: \(formatPopulation(country.population))"
        descriptionLabel.text = country.description
    }
    
    private func formatPopulation(_ population: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: population)) ?? String(population)
    }
}
