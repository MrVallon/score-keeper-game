//
//  ContentView.swift
//  ScoreKeeper
//
//  Created by Сергей Железняк on 1/5/25.
//

import SwiftUI

struct ContentView: View {
    @State private var players: [Player] = [
        Player(name: "Elisha", score: 0),
        Player(name: "Andre", score: 0),
        Player(name: "Jasmine", score: 0),
    ]
    @State private var isShowModal = false
    @State private var rollTrigger: Bool = false
    @State private var currentPlayer = Player(name: "", score: 0)
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Score Keeper")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Button("Add player", systemImage: "plus") {
                    players.append(Player(name: "", score: 0))
                }
            }
            .padding(.bottom)
            
            
            
            Grid {
                GridRow {
                    Text("Player")
                        .gridColumnAlignment(.leading)
                    Text("Score")
                        .gridColumnAlignment(.leading)
                }
                .font(.headline)
                
                Divider()
            }
            
            ScrollView {
                Grid {
                    ForEach($players) { $player in
                        GridRow {
                            TextField("name", text: $player.name)
                            
                            Spacer()
                            
                            Text("\(player.score)")
                                .padding(.trailing)
                            
                            Button {
                                isShowModal.toggle()
                                currentPlayer = player
//                                currentPlayer = $player
                            } label: {
                                Text("Play game")
                            }
                            .buttonStyle(.bordered)
                            .disabled(player.name.isEmpty || player.name.count < 3)
                        }
                        .padding(.vertical, 5)
                    }
                    .gridColumnAlignment(.leading)
                }
            }
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isShowModal) {
            DiceView(currentPlayer: $currentPlayer)
        }
    }
}

#Preview {
    ContentView()
}
