//
//  DataThreadViewController.swift
//  Lesson4
//
//  Created by Егор Бадмаев on 13.04.2024.
//

import UIKit

class DataThreadViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.textContainer.maximumNumberOfLines = 10
        
        DispatchQueue.main.async {
            self.textView.text = "DispatchQueue.main.async(execute:) (аналог runOnUiThread)\n"
            self.textView.text.append("Выполняется немедленно в основном потоке.\n")
            self.textView.text.append("---\n")
        }
        
        performSelector(onMainThread: #selector(updateTextViewWithPerformSelector), with: nil, waitUntilDone: true)
        
        performSelector(inBackground: #selector(updateTextViewWithPerformSelectorAfterDelay), with: nil)
    }
    
    @objc func updateTextViewWithPerformSelector() {
        DispatchQueue.main.async {
            self.textView.text.append("UIView.performSelector(onMainThread:with:waitUntilDone:) (аналог post)\n")
            self.textView.text.append("Выполняется в основном потоке после завершения всех предыдущих операций.\n")
            self.textView.text.append("---\n")
        }
    }
    
    @objc func updateTextViewWithPerformSelectorAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.textView.text.append("UIView.performSelector(afterDelay:withObject:) (аналог postDelayed)\n")
            self.textView.text.append("Выполняется в основном потоке после задержки.\n")
            self.textView.text.append("---\n")
        }
    }
}
