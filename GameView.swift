//
//  SwiftUIView.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/9/25.
//

import SwiftUI
import AVKit

struct GameView: View {

    //array of keys
    @State private var keys: [[Key]] = (0..<4).map { row in
        (0..<2).map { col in
            Key(id: row * 2 + col)
        }
    }

    //empty cariable to store the id of the target key
    @State private var targetKeyID: Int? = nil
    
    //variable to control the animation of the green flash
    @State private var isFlashing = false
    
    //dictionary for the colors that show after shuffle
    @State private var finalColors: [Int: Color] = [:]
    
    //alert variables
    @State private var showResultAlert = false
    @State private var wasCorrect = false

    //used for music
    @State private var player: AVAudioPlayer?
    
    //shuffling and round counter
    @State var shuffling = false
    @State var round: Int = 1

    //formations
    let formations = Formations().formations

    //possible key colors
    let keyColors: [Color] = [
        .red, .orange, .yellow, .green, .blue, .teal, .purple, .pink,
    ]
    
    // allows for the alert to take you back to the content view
    @Environment(\.dismiss) private var dismiss


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

                        guard !shuffling else { return }

                        wasCorrect = (key.id == targetKeyID)
                        showResultAlert = true

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

        }
        //starts the game immediately
        .onAppear() {
            Task {
                //gives the player time to react when the open it up
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    startGame()
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
        //alert with ternaries for when you click a key (correct vs incorrect)
        .alert(
            wasCorrect ? "Correct" : "Incorrect",
            isPresented: $showResultAlert
        ) {
            Button("Play Again") {
                round = wasCorrect ? round + 1 : 1
                resetBoard()
                startGame()
            }

            Button("Main Menu") {
                resetBoard()
                //takes you back to content view
                dismiss()
            }
        } message: {
            Text(
                wasCorrect
                ? "You tracked the correct key."
                : "You lost track of the key."
            )
        }

    }

    //function that makes the game go
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
    
    //helps to reset the keys between rounds
    func resetBoard() {
        finalColors = [:]
        isFlashing = false
        shuffling = false
        targetKeyID = nil

        // reset to default formation
        keys = (0..<4).map { row in
            (0..<2).map { col in
                Key(id: row * 2 + col)
            }
        }
    }


    //function for each shuffle
    func shuffle() {
        
        let random = Double.random(in: 0...1)

        if random < 0.2 {
            randomShuffle()
        } else {
            guard let formation = formations.randomElement() else { return }
            
            applyFormation(formation)
        }

    }

    //sometimes the shuffle is random like this to shuffle he keys better
    func randomShuffle() {
        var flatKeys = keys.flatMap { $0 }
        flatKeys.shuffle()

        keys = stride(from: 0, to: flatKeys.count, by: 2).map {
            Array(flatKeys[$0..<$0 + 2])
        }
    }

    //helps the shuffle methods work
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

    //for music
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
