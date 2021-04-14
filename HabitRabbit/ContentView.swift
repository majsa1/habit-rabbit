//
//  ContentView.swift
//  HabitRabbit
//
//  Created by Marjo Salo on 01/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var habits = Habits()
    @State var showAddView = false
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    ForEach(habits.items) { habit in
                        if let index = habits.items.firstIndex(where: { $0.id == habit.id }) {
                            NavigationLink(destination: DetailView(habit: $habits.items[index])) {
                                VStack(alignment: .leading) {
                                    Text(habit.name)
                                        .font(.headline)
                                    HStack {
                                        Text(habit.goal == 1 ? "Goal: 1 time" : "Goal: \(habit.goal) times")
                                        Spacer()
                                        if habit.count == 1 {
                                            Text(habit.completed ? "Goal reached!" : "Current: 1 time")
                                                .font(habit.completed ? .headline : .body)
                                                .foregroundColor(habit.completed ? .blue : .black)
                                        } else {
                                            Text(habit.completed ? "Goal reached!" : "Current: \(habit.count) times")
                                                .font(habit.completed ? .headline : .body)
                                                .foregroundColor(habit.completed ? .blue : .black)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                    .onMove(perform: moveItems)
                }
                
                Section {
                    HStack {
                        Spacer()
                        ZStack {
                        SpeechBubble()
                            .stroke(Color.black, style: StrokeStyle(lineWidth: 2))
                            .background(SpeechBubble().fill(Color.white))
                            .shadow(radius: 2)
                           
                        Text("Track your habits and feed me 🥕🥕!")
                            .padding()
                            .multilineTextAlignment(.center)
                        }
                        .frame(width: 150, height: 100)
                    }
                }
                .listRowBackground(Color(#colorLiteral(red: 0.9482969642, green: 0.950376451, blue: 0.9678817391, alpha: 1)))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("HabitRabbit")
            .navigationBarItems(leading: Text("🐰")
                .font(.system(size: 46)), trailing: Button(action: {
                showAddView = true
            }) {
                Image(systemName: "plus")
            })
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton() }
            }
            .sheet(isPresented: $showAddView) {
                AddView(habits: habits)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        habits.items.remove(atOffsets: offsets)
    }
    func moveItems(from source: IndexSet, to destination: Int) {
        habits.items.move(fromOffsets: source, toOffset: destination)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
