//
//  Player.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 07/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

enum CurrentPlayer {
    case Player1
    case Player2
}

class Player {
    var name : String
    var listOfPersonageSelected = [Personage]()
    
    init() {
        self.name = ""
    }
    
    func won() -> Bool {
        var isWon = true
        
        for personage in listOfPersonageSelected {
            if !personage.isDead() {
                isWon = false
                break
            }
        }
        
        return isWon
    }
}
