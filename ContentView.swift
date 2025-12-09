import SwiftUI

struct ContentView: View {
    @State var key: Key
    var body: some View {
        VStack {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {

                ForEach(0..<8) { i in
                    Image(key.image)
                }
            }
        }
    }
}
