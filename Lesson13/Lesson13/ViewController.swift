//
//  ViewController.swift
//  Lesson13
//
//  Created by Daria Nikitina on 03.12.2024.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {
    private var todos: [Todo] = []
    private var imageUrls: [String] = [
        "https://loremflickr.com/200/300",
        "https://fakeimg.pl/200x300/?text=Image",
        "https://random.imagecdn.app/200/300"
    ]
    @IBOutlet weak var tableView: UITableView!
    private let apiService: ApiService = ApiServiceImpl()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoCell.self, forCellReuseIdentifier: "TodoCell")
        
        apiService.getTodos(completion: { [weak self] todos in
            guard let self = self else { return }
            if let todos {
                self.todos = todos
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                print("Ошибка! Проверьте подключение к интернету :(")
            }
        })
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoCell
        let todo = todos[indexPath.row]
        cell.configure(
            with: todo,
            imageConfig: ImageConfig(
                url: URL(string: imageUrls[indexPath.row % 3]),
                placeholder: UIImage(systemName: "text.below.photo"),
                options: [
                    .loadDiskFileSynchronously,
                    .cacheOriginalImage,
                    .transition(.fade(0.25))
                ]
            )
        )
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = todos[indexPath.row]
        updateTodo(at: indexPath, todo: todo)
    }

    private func updateTodo(at indexPath: IndexPath, todo: Todo) {
        apiService.updateTodo(todo) { [weak self] result in
            guard let self = self else { return }
            if result {
                todo.completed.toggle()
                todos[indexPath.row] = todo
                DispatchQueue.main.async {
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                }
            } else {
                print("Ошибка! Проверьте подключение к интернету :(")
            }
        }
    }
}
