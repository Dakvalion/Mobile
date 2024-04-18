//
//  CryptoLoaderViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 18.04.2024.
//

import UIKit
import CryptoKit

class CryptoLoaderViewController: UIViewController {
    var key = SymmetricKey(size: SymmetricKeySize(bitCount: 128))
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func encryptButtonClick(_ sender: Any) {
        if let message = textField.text, !message.isEmpty,
           let encryptedPhrase = encrypt(message: message) {
            // Ставим задачу на фон
            DispatchQueue.global(qos: .background).async {
                if let result = self.decrypt(sealedBox: encryptedPhrase, key: self.key) {
                    // Возвращаемся на main поток
                    DispatchQueue.main.async {
                        self.showAlert(message: "\(result)")
                    }
                }
            }
        } else {
            print("message пустой или его нет")
        }
    }
    
    func encrypt(message: String) -> AES.GCM.SealedBox? {
        guard let data = message.data(using: .utf8) else {
            return nil
        }
        let encryptedData = try? AES.GCM.seal(data, using: key)
        return encryptedData
    }
    
    func decrypt(sealedBox: AES.GCM.SealedBox, key: SymmetricKey) -> String? {
        do {
            let data = try AES.GCM.open(sealedBox, using: key)
            if let message = String(data: data, encoding: .utf8) {
                return message
            }
            return nil
        } catch {
            return nil
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Расшифрованное сообщение", message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "ОК", style: .default, handler: nil)
         alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
