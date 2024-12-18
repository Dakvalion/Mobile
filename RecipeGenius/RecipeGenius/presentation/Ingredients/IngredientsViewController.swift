//
//  IngredientsViewController.swift
//  RecipeGenius
//
//  Created by Daria Nikitina on 17.11.2024.
//

import UIKit
import Combine
import data
import domain

class IngredientsViewController: UIViewController {
    private let viewModel = IngredientViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48) / 2, height: 180)
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemBackground
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(IngredientCollectionViewCell.self, forCellWithReuseIdentifier: "IngredientCell")
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupUI() {
        title = "Ингредиенты"
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$ingredients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { [weak self] (error) in
                guard let self = self else { return }
                if let error = error {
                    print("Ошибка: \(error)")
                }
            }
            .store(in: &cancellables)
    }
}

extension IngredientsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientCell", for: indexPath) as? IngredientCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let ingredient = viewModel.ingredients[indexPath.item]
        let domainIngredient = domain.Ingredient(
            name: ingredient.name ?? "",
            weight: ingredient.weight ?? 0.0,
            calories: ingredient.calories ?? 0.0,
            proteins: ingredient.proteins ?? 0.0,
            fats: ingredient.fats ?? 0.0,
            carbohydrates: ingredient.carbohydrates ?? 0.0
        )
        cell.configure(with: domainIngredient)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let ingredient = viewModel.ingredients[indexPath.item]
        print("Selected ingredient: \(ingredient.name ?? "")")
    }
}
