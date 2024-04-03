//
//  RecipeViewController.swift
//  Lesson3
//
//  Created by Дарья Никитина on 30.03.2024.
//

import UIKit
import SafariServices

class RecipeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    private let tableViewData: [(imagePath: String, text: String)] = [
        ("figure.child", "Идеально подходит для новичков"),
        ("clock", "Продолжительность мастер-класса - 2 часа"),
        ("slider.horizontal.below.sun.max", "Картина сохнет в течении 2-3 суток"),
        ("aspectratio", "Форматы холста на ваш выбор"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 12
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func appointmentButtonAction(_ sender: Any) {
        guard let url = URL(string: "https://zuart.ru/msk/mk/fluidart")
        else { return }
        
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
}

extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: tableViewData[indexPath.row].0)
        content.text = tableViewData[indexPath.row].1
        cell.contentConfiguration = content
        return cell
    }
}
