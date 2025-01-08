import SwiftUI

struct DiceView: View {
    @State private var numberOfPipsLeft: Int = Int.random(in: 1...6)
    @State private var numberOfPipsRight: Int = Int.random(in: 1...6)
    @State private var rotation: Double = 0
    @State private var scale: CGFloat = 1.0
    @State private var rollTrigger: Bool = false
    @State private var wishedNumber = ""
    @State private var numberOfAttempts = 3
    
    @Binding var currentPlayer: Player
    
    var body: some View {
        VStack {
            Text("Current player is: \(currentPlayer.name)")
                .padding(.top)
                .font(.title2)
                .bold()
            
            Text("Please select number from 2 - 12")
                .padding()
                .foregroundColor(.gray)
            
            HStack {
                Picker("Select a number", selection: $wishedNumber) {
                    ForEach(2...12, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 100)
                .padding()
                .disabled(numberOfAttempts == 0)
                
                Button("Run") {
                    rollDice()
                }
                .buttonStyle(.bordered)
                .disabled(numberOfAttempts == 0)
            }
            
            Text("The number of attempts: \(numberOfAttempts)")
                .padding()
                .foregroundColor(.gray)
            
            Spacer()
            
            HStack {
                Image(systemName: "die.face.\(numberOfPipsLeft)")
                    .resizable()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(.black, .black)
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(scale)
                
                Image(systemName: "die.face.\(numberOfPipsRight)")
                    .resizable()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(.black, .black)
                    .rotationEffect(.degrees(rotation))
                    .scaleEffect(scale)
            }
            Spacer()
        }
        .padding()
    }
    
    private func rollDice() {
        numberOfAttempts -= 1
        withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
            rotation += 720  // Два оборота
            scale = 1.2  // Увеличение при броске
        }
        
        // С небольшой задержкой меняем число и возвращаем масштаб
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            numberOfPipsLeft = Int.random(in: 1...6)
            numberOfPipsRight = Int.random(in: 1...6)
            withAnimation(.easeOut(duration: 0.5)) {
                scale = 1.0
            }
        }
    }
}

#Preview {
    @Previewable @State var previewPlayer = Player(name: "Player", score: 0)
    
    DiceView(currentPlayer: $previewPlayer)
}

