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
    var gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack {
            
            LazyVGrid( columns: gridColumns, spacing: 8 ) {

                ForEach(keys, 0..<keys.count) { r in
                    
                    ForEach(keys[r], 0..<keys[r].count) { c in
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                move.toggle()
                            }
                        } label: {
                            Image(keys[r][c].image)
                                .resizable()
                                .scaledToFit()
                        }
                        .offset(x: move ? 0 : 150, y: 0)
                    }
                    
                }
                
            }
            
        }
        .onAppear() {
            for r in 0..<4 {
                for c in 0..<2 {
                    keys[r].append(Key(id: 0))
                }
            }
        }
        .frame(width: .infinity, height: .infinity)
        .backgroundStyle(.black)
    }
}

#Preview {
    GameView()
}
