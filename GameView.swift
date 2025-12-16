//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI
import AVKit

struct GameView: View {

    @State private var keys: [[Key]] = (0..<4).map { row in
        (0..<2).map { col in
            Key(id: row * 2 + col)
        }
    }

    @State private var targetKeyID: Int? = nil
    @State private var isFlashing = false
    @State private var finalColors: [Int: Color] = [:]

    @State private var player: AVAudioPlayer?
    
    @State var shuffling = false
    @State var round: Int = 1

    let formations = Formations().formations

    let keyColors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .teal, .purple, .pink,
    ]

    var body: some View {
        VStack {

            Text("Round \(round)")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .opacity(shuffling ? 0 : 1)
                .offset(y: shuffling ? -40 : 0)
                .animation(.easeInOut(duration: 0.5), value: shuffling)

            // Appears before the shuffle

            Text("FOCUS")
                .foregroundStyle(.white)
                .font(.largeTitle)
                .opacity(shuffling ? 1 : 0)
                .offset(y: shuffling ? 0 : 40)
                .animation(.easeInOut(duration: 0.5), value: shuffling)

            let flatKeys = keys.flatMap { $0 }
            // Organized keys in grid
            LazyVGrid(
                columns: [GridItem(.flexible()), GridItem(.flexible())],
                spacing: 8
            ) {
                ForEach(flatKeys) { key in
                    Button {

                        if key.id == targetKeyID {
                            // Correct key pressed
                            print("Correct key pressed!")
                            round += 1
                            startGame()
                        }

                    } label: {
                        Image(key.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .colorMultiply(
                                key.id == targetKeyID && isFlashing
                                    ? .green
                                    : finalColors[key.id] ?? .white
                            )
                            .animation(
                                .easeInOut(duration: 0.5),
                                value: isFlashing
                            )
                    }
                        .disabled(shuffling)
                }
            }

            Button {
                startGame()
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
            .disabled(shuffling)
            .opacity(shuffling ? 0.3 : 1)

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }

    func startGame() {

        targetKeyID = Int.random(in: 0..<8)

        withAnimation(.easeInOut(duration: 0.5)) {
            isFlashing = true
        }

        Task {

            try? await Task.sleep(nanoseconds: 500_000_000)
            
            shuffling = true

            try? await Task.sleep(nanoseconds: 1000_000_000)
            withAnimation(.easeInOut(duration: 0.5)) {
                isFlashing = false
            }
            // Play music
            playSound(named: "Limbo Keys")
            // Goes for 16 bar in the song
            for _ in 0...16 {
                // Roughly 200 bpm
                try? await Task.sleep(nanoseconds: 300_000_000)

                withAnimation(.easeInOut(duration: 0.3)) {
                    shuffle()
                }
            }

            shuffling = false

            var colors = keyColors.shuffled()
            
            withAnimation(.easeInOut(duration: 0.5)) {
                finalColors = Dictionary(
                    uniqueKeysWithValues: keys.flatMap { $0 }.map {
                        ($0.id, colors.removeFirst())
                    }
                )
            }
            
        }
    }

    func shuffle() {
        
        let random = Double.random(in: 0...1)

        if random < 0.2 {
            randomShuffle()
        } else {
            guard let formation = formations.randomElement() else { return }
            
            applyFormation(formation)
        }

    }

    func randomShuffle() {
        var flatKeys = keys.flatMap { $0 }
        flatKeys.shuffle()

        keys = stride(from: 0, to: flatKeys.count, by: 2).map {
            Array(flatKeys[$0..<$0 + 2])
        }
    }

    func applyFormation(_ formation: [[Int]]) {

        let flatKeys = keys.flatMap { $0 }

        for r in 0..<formation.count {
            for c in 0..<formation[r].count {

                let id = formation[r][c]

                if let key = flatKeys.first(where: { $0.id == id }) {
                    keys[r][c] = key
                }
            }
        }

    }

    func playSound(named name: String) {
        // Check if sound file even exists
        guard let url = Bundle.main.url(forResource: name, withExtension: "wav") else {
            print("Sound file not found")
            return
        }
        // Play sound, catch 
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }

}

#Preview {
    GameView()
}
