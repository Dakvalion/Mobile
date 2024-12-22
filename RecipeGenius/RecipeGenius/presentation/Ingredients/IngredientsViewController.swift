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
    private let viewModel: IngredientViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(IngredientTableViewCell.self, forCellReuseIdentifier: "IngredientCell")
        return table
    }()
    
    init() {
        self.viewModel = ViewModelFactory().createIngredientsViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ViewModelFactory().createIngredientsViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        tableView.dataSource = self
        tableView.delegate = self
        if viewModel.isLogin {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"),
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(openProfilePage))
        }
    }
    
    private func setupUI() {
        title = "Ингредиенты"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.$ingredients
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$error
            .receive(on: DispatchQueue.main)
            .sink { error in
                if let error = error {
                    print("Ошибка: \(error)")
                }
            }
            .store(in: &cancellables)
    }
    
    @objc func openProfilePage() {
        let profileVM = ViewModelFactory().createProfileViewModel()
        let profileVC = ProfileViewController(viewModel: profileVM)
        navigationController?.pushViewController(profileVC, animated: true)
    }
}

extension IngredientsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath) as! IngredientTableViewCell
        let ingredient = viewModel.ingredients[indexPath.row]
        cell.configure(with: ingredient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ingredient = viewModel.ingredients[indexPath.row]
        if let detailVC = splitViewController?.viewController(for: .secondary) as? IngredientDetailViewController {
            detailVC.ingredient = ingredient
        } else {
            let detailVC = IngredientDetailViewController()
            detailVC.ingredient = ingredient
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
