import SwiftUI

struct ContentView: View {

    @AppStorage("highScore") var highScore = 0
    @State private var showGame = false
    @State var bob = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Limbo Keys: The Game")
                    .font(.largeTitle)
                    .foregroundStyle(.white)

                HStack {
                    ForEach(0..<3) { c in
                        Image("key")
                            .resizable()
                            .scaledToFit()
                            .brightness(-0.3)
                            .offset(y: bob ? -2 : 2)
                            .animation(
                                .easeInOut(duration: 0.6).repeatForever(autoreverses: true),
                                value: bob
                            )
                            .onAppear { bob = true }
                    }
                }

                Text("Highest Round: \(highScore)")
                    .font(.title)
                    .foregroundStyle(.white)
                    .padding(.vertical, 30)

                Button {
                    showGame = true
                } label: {
                    ZStack {

                        RoundedRectangle(cornerRadius: 30)
                            .frame(width: 150, height: 80)
                            .foregroundStyle(.white)

                        Text("START")
                            .font(.largeTitle)
                            .foregroundStyle(.black)

                    }
                }
                .navigationDestination(isPresented: $showGame) {
                    GameView()
                        // removes back button
                        .navigationBarBackButtonHidden(true)
                        .interactiveDismissDisabled(true)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
        }
    }
}
