//
//  ViewController.swift
//  Lesson7
//
//  Created by Дарья Никитина on 18.05.2024.
//

import UIKit
import Starscream

class TimeServiceViewController: UIViewController, WebSocketDelegate {
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var fetchButton: UIButton!
    
    var socket: WebSocket?
    var url = URL(string: "wss://time.cloudflare.com")
    
    @IBAction func fetchTime(_ sender: UIButton) {
        guard let url else { return }
        let request = URLRequest(url: url)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()
    }
    
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .error(let error):
            guard let error = error as? HTTPUpgradeError,
               case .notAnUpgrade(_, let dictionary) = error,
               let date = dictionary["Date"] else {
                return
            }
            DispatchQueue.main.async {
                self.outputLabel.text = date
            }
        default:
            break
        }
    }
}
