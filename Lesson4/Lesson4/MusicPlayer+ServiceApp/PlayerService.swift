//
//  PlayerService.swift
//  Lesson4
//
//  Created by Дарья Никитина on 14.04.2024.
//

import Foundation
import AVKit

class PlayerService: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var totalTime: TimeInterval = 0.0
    @Published var currentTime: TimeInterval = 0.0
    
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    private let songName = "piano"
    private let songFormat = "mp3"
    
    override init() {
        super.init()
        setupAudio()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in
            if success {
                print("Разрешение на уведомления получено")
            } else if let error = error {
                print("Ошибка при запросе разрешения: \(error.localizedDescription)")
            }
        }
    }
    
    func playAudio() {
        player?.play()
        isPlaying = true
        startTimer()
        
        let content = UNMutableNotificationContent()
        content.title = "Никитина Дарья - \(songName).\(songFormat)"
        content.body = "Начало воспроизведения аудиозаписи"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func stopAudio() {
        player?.stop()
        isPlaying = false
        stopTimer()
    }
    
    func audioTime(to time: TimeInterval) {
        player?.currentTime = time
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: songName, withExtension: songFormat) else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.delegate = self
            totalTime = player?.duration ?? 0.0
        } catch {
            assertionFailure("Не смогли создать плеер")
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.updateProgress()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func updateProgress() {
        currentTime = player?.currentTime ?? 0.0
    }
}

extension PlayerService: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        stopAudio()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
