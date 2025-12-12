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

    let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    typealias Formation = [[Int]]
    let formations : [Formation] = [
        /*  Default:
         [
            [0,1],
            [2,3],
            [4,5],
            [6,7]
         ]
         */
        
        //row swap
        [
            [1,0],
            [3,2],
            [5,4],
            [7,6]
        ],
        //full rotate
        [
            [7,6],
            [5,4],
            [3,2],
            [1,0]
        ],
        //row push
        [
            [6,7],
            [0,1],
            [2,3],
            [4,5]
        ],
        //row pull
        [
            [2,3],
            [4,5],
            [6,7],
            [1,0]
        ],
        //double rotate (clockwise)
        [
            [2,0],
            [3,1],
            [6,4],
            [7,5]
        ],
        //column swap
        [
            [6,7],
            [4,5],
            [2,3],
            [0,1]
        ],
        //snake (clockwise)
        [
            [2,0],
            [4,1],
            [6,3],
            [7,5]
        ],
        //square shift
        [
            [4,5],
            [6,7],
            [0,1],
            [2,3]
        ],
        //odd row swap
        [
            [4,5],
            [2,3],
            [0,1],
            [6,7]
        ],
        //even row swap
        [
            [0,1],
            [6,7],
            [4,5],
            [2,3]
        ],
        //diagonal swap
        [
            [3,2],
            [1,0],
            [7,6],
            [5,4]
        ],
        //double rotate (counterclockwise)
        [
            [1,3],
            [0,2],
            [5,7],
            [4,6]
        ],
        //snake (counterclockwise)
        [
            [1,3],
            [0,5],
            [2,7],
            [4,6]
        ]
    ]

    var body: some View {
        VStack {

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

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }

    func shuffle() {
        
        guard let formation = formations.randomElement() else { return }
        
        applyFormation(formation)
        
        /*var flatKeys = keys.flatMap { $0 }

        flatKeys.shuffle()

        keys = stride(from: 0, to: flatKeys.count, by: 2).map { i in
            Array(flatKeys[i..<i + 2])
        }*/
    }
    
    func applyFormation(_ formation: [[Int]]) {
        
        var flatKeys = keys.flatMap { $0 }
        
        for r in 0..<formation.count {
            for c in 0..<formation[r].count {
                
                let id = formation[r][c]
                
                if let key = flatKeys.first(where: { $0.id == id }) {
                    keys[r][c] = key
                }
            }
        }
    }

}

#Preview {
    GameView()
}
