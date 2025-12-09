import SwiftUI

struct ContentView: View {
    @State var key = Key(image: "key",x: 0,y: 0,id: 0)
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
