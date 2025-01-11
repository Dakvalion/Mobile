//
//  IngredientDetailViewController.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 18.12.2024.
//

import UIKit
import domain

class IngredientDetailViewController: UIViewController {
    var ingredient: Ingredient? {
        didSet {
            updateUI()
        }
    }
    
    private lazy var emojiContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 60)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = ingredient?.name
        
        view.addSubview(emojiContainerView)
        emojiContainerView.addSubview(emojiLabel)
        view.addSubview(descriptionLabel)
        
        emojiLabel.text = ingredient?.emoji
        descriptionLabel.text = ingredient?.strDescription
        
        NSLayoutConstraint.activate([
            emojiContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emojiContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            emojiContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emojiContainerView.widthAnchor.constraint(equalToConstant: 120),
            emojiContainerView.heightAnchor.constraint(equalToConstant: 120),
            
            emojiLabel.centerXAnchor.constraint(equalTo: emojiContainerView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: emojiContainerView.centerYAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: emojiContainerView.bottomAnchor, constant: 24),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func updateUI() {
        guard isViewLoaded else { return }
        guard let ingredient = ingredient else {
            title = "Выберите ингредиент"
            descriptionLabel.text = "Выберите ингредиент из списка слева"
            return
        }
        
        title = ingredient.name
        descriptionLabel.text = ingredient.strDescription
    }
}
