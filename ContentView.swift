import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink {
                    GameView()
                } label: {
                    Text("click me")
                }
            }
        }
    }
}
