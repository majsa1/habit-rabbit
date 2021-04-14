//
//  AddView.swift
//  HabitRabbit
//
//  Created by Marjo Salo on 06/04/2021.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var habits: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var count = 0
    @State private var goal = ""
    @State private var showAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Habit", text: $name)
                TextField("Description", text: $description)
                TextField("Number of times to reach goal", text: $goal)
            }
            .navigationBarTitle("Add new habit")
            .navigationBarItems(
                leading:
                    Button("Cancel") {
                        self.presentationMode.wrappedValue.dismiss()
                    },
                trailing:
                    Button("Save") {
                        guard let numericGoal = Int(goal) else {
                            showAlert = true
                            return
                        }
                    
                    let habit = HabitItem(name: name, description: description, count: count, goal: numericGoal)
                    habits.items.append(habit)
                    self.presentationMode.wrappedValue.dismiss()
            })
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Warning"), message: Text("Please enter a numeric amount."), dismissButton: .default(Text("OK")))
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(habits: Habits())
    }
}
