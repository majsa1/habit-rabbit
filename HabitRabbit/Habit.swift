//
//  Habit.swift
//  HabitRabbit
//
//  Created by Marjo Salo on 01/04/2021.
//

import Foundation

struct HabitItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
    let goal: Int
    var completed: Bool {
        count == goal ? true : false
    }
}

class Habits: ObservableObject {
    @Published var items = [HabitItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() { 
        if let items = UserDefaults.standard.data(forKey: "Habits") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([HabitItem].self, from: items) {
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}


