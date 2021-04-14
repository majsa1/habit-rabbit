//
//  DetailView.swift
//  HabitRabbit
//
//  Created by Marjo Salo on 06/04/2021.
//

import SwiftUI

struct DetailView: View {
    @Binding var habit: HabitItem
    @State var counter = Int()
    
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.9482969642, green: 0.950376451, blue: 0.9678817391, alpha: 1))
                .ignoresSafeArea()
            
            GeometryReader { geo in
                VStack(alignment: .leading) {
                    Text(habit.name)
                        .font(.title)
                    Text(habit.description)
                     
                    VStack(alignment: .leading) {
                        HStack {
                            Text(habit.completed ? "Goal reached!" : "Current: \(habit.count)")
                            Spacer()
                            Text("Left: \(habit.goal - habit.count)")
                        }
                        .font(habit.completed ? .headline : .body)
                        .foregroundColor(habit.completed ? .orange : .black)
                    }
                    .padding(.vertical)
            
                    HStack {
                        if habit.count < habit.goal {
                            Button("Add 1") {
                                addButtonTapped()
                            }
                        }
                        if habit.completed {
                            Button("Start over") {
                                resetButtonTapped()
                            }
                        }
                        Spacer()
                        if habit.count > 0 {
                            Button("Remove 1") {
                                removeButtonTapped()
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .frame(height: geo.size.height / 3)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .navigationBarTitle("Details", displayMode: .inline)
            }
            
            VStack {
                if habit.completed {
                    
                    HStack {
                        Spacer()
                        ZStack {
                           SpeechBubble()
                                .stroke(Color.black, style: StrokeStyle(lineWidth: 2))
                                .background(SpeechBubble().fill(Color.white))
                                .shadow(radius: 2)
                            Text("Well done and thanks for the 🥕!")
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .frame(width: 150, height: 120)
                        .padding(40)
                    }
                }
            }
        }
        .onAppear(perform: { counter = habit.count })
    }
    
    func addButtonTapped() {
        withAnimation {
            counter += 1
        }
        habit.count = counter 
    }
    func removeButtonTapped() {
        withAnimation {
            counter -= 1
        }
        habit.count = counter
    }
    func resetButtonTapped() {
        withAnimation {
            counter = 0
        }
        habit.count = counter
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(habit: .constant(HabitItem(name: "Eat a carrot", description: "Every day", count: 5, goal: 5)))
    }
}

