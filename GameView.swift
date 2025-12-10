//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI

struct GameView: View {
    @State var keys: [Key] = []
    var body: some View {
        VStack {
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {

                ForEach(keys, id: \.id) { key in
                    Button {
                        
                    } label: {
                        Image(key.image)
                    }
                }
            }
        }
        .onAppear() {
            for i in 0..<8 {
                keys.append(Key(x: 0, y: 0, id: i))
            }
        }
    }
}

#Preview {
    GameView()
}
