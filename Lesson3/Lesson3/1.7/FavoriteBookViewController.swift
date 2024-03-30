//
//  FavoriteBookViewController.swift
//  Lesson3
//
//  Created by Дарья Никитина on 27.03.2024.
//

import UIKit

/// Задание 1.7
class FavoriteBookViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    var state: State = .empty
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.text = state.text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "favoriteBook",
              let destination = segue.destination as? BookDetailsViewController
        else { return }
        
        destination.callback = { [weak self] state in
            guard let self else { return }
            
            self.state = state
        }
        switch state {
        case .empty:
            destination.state = .empty
        case .book(let name):
            destination.state = .book(name: name)
        }
    }
}

extension FavoriteBookViewController {
    
    enum State {
        case empty
        case book(name: String)
        
        var text: String {
            switch self {
            case .empty:
                return "Тут появится название вашей любимой книги!"
            case .book(let name):
                return "Название Вашей любимой книги: \(name)"
            }
        }
    }
}

typealias BookState = FavoriteBookViewController.State
