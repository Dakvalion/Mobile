//
//  AudioRecordViewController.swift
//  Lesson5
//
//  Created by Дарья Никитина on 22.04.2024.
//

import AVFoundation
import CoreMotion
import UIKit
import Photos

final class AudioRecordViewController: UIViewController,
                                       UIImagePickerControllerDelegate,
                                       UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var recordTitleLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let motionManager = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FileManager.default.fileExists(
            atPath: FileManager.documentsDirectory.appendingPathComponent("RECORD.m4a").path
        ) {
            playButton.isEnabled = false
            recordTitleLabel.text = "Запишите новую запись"
        } else {
            playButton.isEnabled = true
            recordTitleLabel.text = "RECORD.m4a"
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func recordButtonAction(_ sender: Any) {
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        startRecording()
    }
    
    @IBAction func stopButtonAction(_ sender: Any) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        playButton.isEnabled = true
        stopRecording()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        fetchRecording()
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Не смогли создать сессию для прослушивания")
        }
        
        let audioFileName = FileManager.documentsDirectory.appendingPathComponent("RECORD.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder?.record()
        } catch {
            print("Не смогли запустить запись")
        }
    }
    
    func stopRecording() {
        recordTitleLabel.text = "RECORD.m4a"
        audioRecorder?.stop()
    }
    
    func fetchRecording() {
        do {
            let audioFileName = FileManager.documentsDirectory.appendingPathComponent("RECORD.m4a")
            audioPlayer = try AVAudioPlayer(contentsOf: audioFileName)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Ошибка воспроизведения аудиофайла")
        }
    }
    
    @objc func profileImageTapped() {
        if PHPhotoLibrary.authorizationStatus() == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.openImagePicker()
                    }
                case .denied, .restricted:
                    print("Доступ к библиотеке фотографий запрещен")
                case .notDetermined:
                    print("Разрешение еще не было запрошено")
                default:
                    print("Неизвестный статус разрешения")
                }
            }
        } else if PHPhotoLibrary.authorizationStatus() == .authorized {
            DispatchQueue.main.async {
                self.openImagePicker()
            }
        }
    }
    
    func openImagePicker() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension FileManager {
    
    static var documentsDirectory: URL {
        Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
}
