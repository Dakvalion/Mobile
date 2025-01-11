//
//  ListViewAppViewController.swift
//  Lesson12
//
//  Created by Daria Nikitina on 17.11.2024.
//

import UIKit

class ListViewAppViewController: UIViewController {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(BookCell.self, forCellReuseIdentifier: "BookCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    let books: [(String, String)] = [
        ("1984", "Джордж Оруэлл"),
        ("Преступление и наказание", "Фёдор Достоевский"),
        ("Сто лет одиночества", "Габриэль Гарсиа Маркес"),
        ("Улисс", "Джеймс Джойс"),
        ("Война и мир", "Лев Толстой"),
        ("Божественная комедия", "Данте Алигьери"),
        ("Мастер и Маргарита", "Михаил Булгаков"),
        ("Дон Кихот", "Мигель де Сервантес"),
        ("Гамлет", "Уильям Шекспир"),
        ("Братья Карамазовы", "Фёдор Достоевский"),
        ("Анна Каренина", "Лев Толстой"),
        ("Фауст", "Иоганн Вольфганг фон Гёте"),
        ("Одиссея", "Гомер"),
        ("Гордость и предубеждение", "Джейн Остин"),
        ("Великий Гэтсби", "Фрэнсис Скотт Фицджеральд"),
        ("Над пропастью во ржи", "Джером Сэлинджер"),
        ("Три товарища", "Эрих Мария Ремарк"),
        ("Портрет Дориана Грея", "Оскар Уайльд"),
        ("Маленький принц", "Антуан де Сент-Экзюпери"),
        ("Идиот", "Фёдор Достоевский"),
        ("Дюна", "Фрэнк Герберт"),
        ("Властелин колец", "Джон Р. Р. Толкин"),
        ("О дивный новый мир", "Олдос Хаксли"),
        ("Процесс", "Франц Кафка"),
        ("Сказки", "Ханс Кристиан Андерсен"),
        ("Лолита", "Владимир Набоков"),
        ("Над кукушкиным гнездом", "Кен Кизи"),
        ("451 градус по Фаренгейту", "Рэй Брэдбери"),
        ("Бесы", "Фёдор Достоевский"),
        ("Парфюмер", "Патрик Зюскинд")
    ]
}

extension ListViewAppViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookCell else {
            return UITableViewCell()
        }
        cell.configure(with: books[indexPath.row])
        return cell
    }
}
