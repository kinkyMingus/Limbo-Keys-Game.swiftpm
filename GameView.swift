//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI

struct GameView: View {
    //@State var keys: [[Key]] = []
    @State private var keys: [[Key]] = (0..<4).map { row in
        (0..<2).map { col in
            Key(id: row * 2 + col)
        }
    }

    @State private var move = false

    let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {

            let flatKeys = keys.flatMap { $0 }

            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {
                ForEach(flatKeys) { key in
                    Button{
                        
                    } label: {
                        Image(key.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    }
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    move.toggle()
                }
            }
            
            Button {
                
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

            /*LazyVGrid(columns: gridColumns, spacing: 8) {
            
            
            
                ForEach(0..<keys.count, id: \.self) { r in
            
                    ForEach(0..<keys[r].count, id: \.self) { c in
            
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                keys.isMoving.toggle()
                            }
                        } label: {
                            let key = keys[r][c]
                            Image(key.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 120, height: 120)
                        }
                        .offset(x: keys.isMoving ? 0 : 150, y: 0)
                    }
            
                }
            
            }*/

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }

}

#Preview {
    GameView()
}
