//
//  Key.swift
//  Limbo Keys Game
//
//  Created by JACKSON GERAMBIA on 12/9/25.
//

import Foundation
import SwiftUI

class Key : Identifiable {
    // number of key: 0-7
    let id : Int
    var image = "key"
    var isMoving: Bool = false
    
    init(id: Int, image: String = "key") {
        self.image = image
        self.id = id
    }
}
