import SwiftUI

struct ContentView: View {

    @State private var showGame = false

    var body: some View {
        NavigationStack {
            VStack {
                Button {
                    showGame = true
                } label: {
                    Text("click me")
                        .font(.largeTitle)
                }
                .navigationDestination(isPresented: $showGame) {
                    GameView()
                    // removes back button
                        .navigationBarBackButtonHidden(true)
                        .interactiveDismissDisabled(true)
                }
            }
        }
    }
}
