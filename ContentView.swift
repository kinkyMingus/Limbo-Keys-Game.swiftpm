import SwiftUI

struct ContentView: View {

    @State private var showGame = false

    var body: some View {
        NavigationStack {
            VStack {
                Text("Limbo Keys: The Game")
                    .font(.largeTitle)
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
