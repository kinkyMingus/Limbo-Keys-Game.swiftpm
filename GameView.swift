//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI

struct GameView: View {
    @State var keys: [[Key]] = []
    @State var move: Bool = false
    
    var columns : [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    
    var body: some View {
        VStack {
            LazyVGrid(
                columns: columns,
                spacing: 8
            ) {

                ForEach(keys, 0..<keys.count) { r in
                    ForEach(keys[r], 0..<keys[r].count){ c in
                        Button {
                            withAnimation(.easeInOut(diration: 0.5)) {
                                move.toggle()
                            }
                        } label: {
                            Image(keys[r][c].image)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                }
            }
        }
        .onAppear() {
            for i in 0..<4 {
                for _ in 0..<2 {
                    keys[i].append(Key(x: 0, y: 0, id: i))
                }
            }
        }
    }
}

#Preview {
    GameView()
}
