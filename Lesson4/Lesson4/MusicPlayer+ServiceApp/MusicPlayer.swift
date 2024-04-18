//
//  MusicPlayer.swift
//  Lesson4
//
//  Created by Дарья Никитина on 31.03.2024.
//

import SwiftUI

struct MusicPlayer: View {
    @StateObject private var service = PlayerService()
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    ButtonView(image: "chevron.left")
                    Spacer()
                    ButtonView(image: "repeat")
                }
                
                Text("Now Playing")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.all)
            
            Image("piano")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
            
            Text("Piano Music")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 25)
            
            Text("Author ft. Author 2")
            
            VStack {
                Slider(value: Binding(get: {
                    service.currentTime
                }, set: { newValue in
                    service.audioTime(to: newValue)
                }), in: 0...service.totalTime)
                .padding([.top, .trailing, .leading], 20)
                
                HStack {
                    Text(timeString(time: service.currentTime))
                    Spacer()
                    Text(timeString(time: service.totalTime))
                }
                .font(.caption)
                .padding([.trailing, .leading], 20)
            }
            
            HStack(spacing: 20) {
                Button(action: {}, label: {
                    ButtonView(image: "backward.fill")
                })
                
                Button(action: {}, label: {
                    Image(systemName: service.isPlaying ? "pause.fill" : "play.fill")
                        .padding(.all, 20)
                        .foregroundColor(.pink)
                        .background(
                            Circle()
                                .foregroundColor(.white)
                                .overlay(
                                    Circle().stroke(Color.secondary.opacity(0.4), lineWidth: 1))
                        )
                        .onTapGesture {
                            service.isPlaying ? service.stopAudio() : service.playAudio()
                        }
                    }
                )
                
                Button(action: {}, label: {
                    ButtonView(image: "forward.fill")
                })
            }
            .padding(.top, 25)
            
            Spacer()
        }
    }
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
}

#Preview {
    MusicPlayer()
}
