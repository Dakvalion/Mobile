//
//  ThreadsView.swift
//  Lesson4
//
//  Created by Дарья Никитина on 13.04.2024.
//

import SwiftUI

struct ThreadsView: View {
    @State private var output = "< ... >"
    @State private var days = ""
    @State private var lessons = ""
    @State private var counter = 0
    private let previousName: String?
    
    init() {
        previousName = Thread.current.name
        Thread.current.name = "МОЙ НОМЕР ГРУППЫ: 10, НОМЕР ПО СПИСКУ: 17, МОЙ ЛЮБИМЫЙ ФИЛЬМ: Гарри Поттер и узник Азкабана"
        print("Stack: \(Thread.callStackSymbols)")
    }
    
    var body: some View {
        VStack {
            TextField("Количество дней", text: $days)
            TextField("Количество пар", text: $lessons)
            
            Button("Рассчитать") {
                calculate()
            }
            .padding(.all)
            
            Text(output)
            Text("Новое имя потока: \(Thread.current.name ?? "")" + "\nПредыдущее имя потока: \(previousName ?? "")")
        }
        .padding()
    }
    
    private func calculate() {
        Thread {
            let numberThread = counter
            counter += 1
            print("Запущен поток №\(numberThread) студентом группы БСБО-10-21 номер по списку №17")
            
            let endTime = Date().addingTimeInterval(20)
            while Date() < endTime {
                Thread.sleep(forTimeInterval: 0.1)
            }
            print("Выполнен поток №\(numberThread)")
        }.start()
        
        Thread {
            guard let lessons = Float(lessons),
                  let days = Float(days),
                  days > 0
            else {
                DispatchQueue.main.async {
                    self.output = "Введены некорректные данные"
                }
                return
            }
            DispatchQueue.main.async {
                self.output = "Среднее кол-во пар: " + String(lessons / days)
            }
        }.start()
    }
}
