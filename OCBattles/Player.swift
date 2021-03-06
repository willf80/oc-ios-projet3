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
    
    //Is user to change the current player
    //If current player is player1, when we call this function
    //it return player2
    mutating func nextPlayer() {
        switch self {
        case .Player1:
            self = .Player2
        case .Player2:
            self = .Player1
        }
    }
}

class Player {
    var name : String
    var listOfPersonageSelected = [Personage]()
    var numberOfLaps: Int
    
    init() {
        name = ""
        numberOfLaps = 0
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
    
    private func teamList(listOfPersonage: [Personage]) -> Void {
        for i in 0..<listOfPersonage.count {
            let personage = listOfPersonage[i]
            
            var text = ""
            if personage.weapon is WeaponAttack{
                let weaponAttack = personage.weapon as! WeaponAttack
                text = "\(i+1). \(personage.pseudoName!) [Vie : \(personage.life), \(weaponAttack.name) : \(weaponAttack.damage)]"
            }else{
                let weaponCare = personage.weapon as! WeaponCare
                text = "\(i+1). \(personage.pseudoName!) [Vie : \(personage.life), \(weaponCare.name) : \(weaponCare.care)]"
            }
            
            if(personage.isDead()){
                text += "(MORT)"
            }
            
            print(text)
        }
    }
    
    func showTeamListWithDetails() -> Void{
        print("------------------")
        print("Liste de l'équipe [\(name)]")
        teamList(listOfPersonage: listOfPersonageSelected)
    }
    
    func showTeamListWithDetails(headerMessage: String) -> Void{
        print("------------------")
        print(headerMessage)
        print("")
        teamList(listOfPersonage: listOfPersonageSelected)
    }
    
    func showTeamListWithoutHealer(headerMessage: String) -> Void {
        print("------------------")
        print(headerMessage)
        print("")
        teamList(listOfPersonage: getPersonageWithoutHealer())
    }
}
