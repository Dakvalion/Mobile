//
//  ButtonView.swift
//  Lesson4
//
//  Created by Дарья Никитина on 31.03.2024.
//

import SwiftUI

struct ButtonView: View {
    var image: String
    
    var body: some View {
        Button(action: {
            print("Some action")
        }, label: {
            Image(systemName: image)
                .padding(.all, 20)
                .foregroundColor(.pink)
                .background(
                    Circle()
                        .foregroundColor(.white)
                        .overlay(
                            Circle().stroke(Color.secondary.opacity(0.4), lineWidth: 1)
                        )
                )
        })
    }
}

#Preview {
    ButtonView(image: "play.fill")
}
