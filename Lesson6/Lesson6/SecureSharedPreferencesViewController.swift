//
//  SecureSharedPreferencesViewController.swift
//  Lesson6
//
//  Created by Дарья Никитина on 12.05.2024.
//

import UIKit

class SecureSharedPreferencesViewController: UIViewController {
    
    @IBOutlet weak var favouritePoetryTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "poetryName",
            kSecReturnData: kCFBooleanTrue as Any
        ]
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess else {
            print("❗️Ошибка")
            return
        }
        
        if let resultData = result as? Data {
            favouritePoetryTextField.text = String(data: resultData, encoding: .utf8)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let poetryName = favouritePoetryTextField.text,
              !poetryName.isEmpty,
              let data = poetryName.data(using: .utf8)
        else { return }
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: "poetryName",
            kSecValueData: data
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            print("⚠️ Дубликат")
            return
        }
        guard status == errSecSuccess else {
            print("❗️Ошибка")
            return
        }
    }
}
