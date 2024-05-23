//
//  ViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 10.05.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var favouriteFilmOrSeries: UITextField!
    @IBOutlet weak var listNumberTextField: UITextField!
    @IBOutlet weak var groupTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTextField.text = UserDefaults.standard.string(forKey: "GROUP")
        listNumberTextField.text = UserDefaults.standard.string(forKey: "NUMBER")
        favouriteFilmOrSeries.text = UserDefaults.standard.string(forKey: "FAVORITE_MOVIE")
    }
    
    @IBAction func saveDataButtonTapped(_ sender: Any) {
        if let groupNumber = groupTextField.text,
           !groupNumber.isEmpty {
            UserDefaults.standard.set(groupNumber, forKey: "GROUP")
        }
        if let studentNumber = Int(listNumberTextField.text ?? ""),
           studentNumber > 0 {
            UserDefaults.standard.set(studentNumber, forKey: "NUMBER")
        }
        if let favoriteMovie = favouriteFilmOrSeries.text,
           !favoriteMovie.isEmpty {
            UserDefaults.standard.set(favoriteMovie, forKey: "FAVORITE_MOVIE")
        }
    }
}
