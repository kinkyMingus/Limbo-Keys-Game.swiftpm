//
//  File.swift
//  Limbo Keys Game
//
//  Created by DAVID SHOW on 12/15/25.
//

import Foundation

struct Formations {
    typealias Formation = [[Int]]
    let formations: [Formation] = [
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
            [1, 0],
            [3, 2],
            [5, 4],
            [7, 6],
        ],
        //full rotate
        [
            [7, 6],
            [5, 4],
            [3, 2],
            [1, 0],
        ],
        //row push
        [
            [6, 7],
            [0, 1],
            [2, 3],
            [4, 5],
        ],
        //row pull
        [
            [2, 3],
            [4, 5],
            [6, 7],
            [1, 0],
        ],
        //double rotate (clockwise)
        [
            [2, 0],
            [3, 1],
            [6, 4],
            [7, 5],
        ],
        //column swap
        [
            [6, 7],
            [4, 5],
            [2, 3],
            [0, 1],
        ],
        //snake (clockwise)
        [
            [2, 0],
            [4, 1],
            [6, 3],
            [7, 5],
        ],
        //square shift
        [
            [4, 5],
            [6, 7],
            [0, 1],
            [2, 3],
        ],
        //odd row swap
        [
            [4, 5],
            [2, 3],
            [0, 1],
            [6, 7],
        ],
        //even row swap
        [
            [0, 1],
            [6, 7],
            [4, 5],
            [2, 3],
        ],
        //diagonal swap
        [
            [3, 2],
            [1, 0],
            [7, 6],
            [5, 4],
        ],
        //double rotate (counterclockwise)
        [
            [1, 3],
            [0, 2],
            [5, 7],
            [4, 6],
        ],
        //snake (counterclockwise)
        [
            [1, 3],
            [0, 5],
            [2, 7],
            [4, 6],
        ],
    ]
}
