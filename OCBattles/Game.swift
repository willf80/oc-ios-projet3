//
//  Menu.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 03/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

class Game {
    
    //  Indicates whether the game is over or not
    private var quit = false
    
    func startNewGame() -> Void {
        //  Loop of game
        //  Do not quit while new part is not ended
        //  The end of the game may be due to the fact that:
        //  - One of the two players wins the game
        //  - One of the players decides to stop the game
        repeat {
            
        }while !quit
    }
    
    func restartGame() -> Void {
        
    }
}
