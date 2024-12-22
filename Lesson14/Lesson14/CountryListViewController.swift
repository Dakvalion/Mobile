//
//  CountryListViewController.swift
//  Lesson14
//
//  Created by Daria Nikitina on 19.12.2024.
//

import UIKit

class CountriesListViewController: UITableViewController {
    
    private var countries: [Country] = [
        Country(name: "Франция",
               capital: "Париж",
               population: 67_390_000,
               description: "Франция - государство в Западной Европе. Столица - город Париж. Территория включает в себя метрополию и заморские регионы."),
        Country(name: "Германия",
               capital: "Берлин",
               population: 83_240_000,
               description: "Германия - государство в Центральной Европе. Является федеративной парламентской республикой."),
        Country(name: "Италия",
               capital: "Рим",
               population: 60_360_000,
               description: "Италия - государство в Южной Европе, в центре Средиземноморья. Занимает Апеннинский полуостров."),
    ]
    
    override var splitViewController: UISplitViewController? {
        return self.parent as? UISplitViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Страны"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        if let detailVC = splitViewController?.viewController(for: .secondary) as? CountryDetailViewController,
           !countries.isEmpty {
            detailVC.country = countries[0]
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let country = countries[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = country.name
        content.secondaryText = country.capital
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        
        if let detailVC = splitViewController?.viewController(for: .secondary) as? CountryDetailViewController {
            detailVC.country = country
        } else {
            let detailVC = CountryDetailViewController()
            detailVC.country = country
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
