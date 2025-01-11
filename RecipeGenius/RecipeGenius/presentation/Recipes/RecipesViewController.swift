//
//  RecipesViewController.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 07.10.2024.
//

import UIKit

class RecipesViewController: UIViewController {
    private let viewModel: RecipeViewModel
    private let noRecipesLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет сгенерированных рецептов"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    init(viewModel: RecipeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Рецепты"
        view.backgroundColor = .systemBackground
        view.addSubview(noRecipesLabel)
        noRecipesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noRecipesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noRecipesLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
