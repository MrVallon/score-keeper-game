import SwiftUI

struct GameResultScreen: View {
    var score: Int
    @Binding var attempts: Int
    @Binding var isShowModal: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "trophy")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .foregroundStyle(.yellow)
            
            Text("Congratulations!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            
            Text("You've completed the game!")
                .font(.title2)
                .foregroundStyle(.secondary)
            
            VStack(spacing: 8) {
                Text("Final Score: \(score)")
                    .font(.title3)
                    .fontWeight(.medium)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            
            Spacer()
            
            Button(action: {
                attempts = 3
            }) {
                Text("Play Again")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 40)
            }
            
            Spacer()
            
            Button("Score Table") {
                isShowModal.toggle()
            }
        }
    }
}

#Preview {
    GameResultScreen(score: 0, attempts: .constant(0), isShowModal: .constant(false))
}
