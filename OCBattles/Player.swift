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
    
    func getPersonageWithoutHealer() -> [Personage] {
        var listPersonage = [Personage]()
        for personage in listOfPersonageSelected {
            if personage is PersonageHealer{
                continue
            }
            
            listPersonage += [personage]
        }
        
        return listPersonage
    }
    
    func isAllPersonageAreDead() -> Bool {
        var isDead = true
        
        for personage in listOfPersonageSelected {
            if !personage.isDead() {
                isDead = false
                break
            }
        }
        
        return isDead
    }
}
