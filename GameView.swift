//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI

struct GameView: View {

    @State private var keys: [[Key]] = (0..<4).map { row in
        (0..<2).map { col in
            Key(id: row * 2 + col)
        }
    }
    
    @State var focus = false

    var body: some View {
        VStack {
            
            Text("FOCUS")
                .foregroundStyle(.red)
                .font(.largeTitle)
                .opacity(focus ? 1 : 0)
                .offset(y: focus ? 0 : 40)
                .animation(.easeInOut(duration: 0.5), value: focus)

            let flatKeys = keys.flatMap { $0 }

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {
                ForEach(flatKeys) { key in
                    Button {

                    } label: {
                        Image(key.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
            }

            Button {
                
                focus = true

                Task {
                    for _ in 0...10 {
                        
                        try? await Task.sleep(nanoseconds: 400_000_000)

                        withAnimation(.easeInOut(duration: 0.3)) {
                            shuffle()
                        }
                    }
                    focus = false
                }

            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: 120, height: 60)
                        .foregroundStyle(.white)

                    Text("Start")
                        .font(.title)
                        .foregroundStyle(.black)
                }
            }
            .transition(.opacity)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }

    func shuffle() {

        var flatKeys = keys.flatMap { $0 }

        flatKeys.shuffle()

        keys = stride(from: 0, to: flatKeys.count, by: 2).map { i in
            Array(flatKeys[i..<i + 2])
        }
    }

}

#Preview {
    GameView()
}
