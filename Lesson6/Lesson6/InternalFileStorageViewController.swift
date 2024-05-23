//
//  InternalFileStorageViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//

import UIKit

class InternalFileStorageViewController: UIViewController {
    
    @IBOutlet weak var inputTextView: UITextView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("history.txt")
            
            do {
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                inputTextView.text = content
            } catch {
                print("❗️Ошибка загрузки: \(error)")
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let input = inputTextView.text,
              !input.isEmpty else { return }
        
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent("history.txt")
            
            do {
                try input.write(to: fileURL, atomically: false, encoding: .utf8)
            } catch {
                print("❗️Ошибка сохранения: \(error)")
            }
        }
    }
}
