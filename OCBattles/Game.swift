//
//  Menu.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 03/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

class Game {
    
    //  Player1 is the first player start a game
    let currentPlayer = CurrentPlayer.Player1
    
    let player1 = Player()
    let player2 = Player()
    
    //  Indicates whether the game is over or not
    private var quit = false
    
    func startNewGame() -> Void {
        
        //  Define player name
       teamDefinition()
        
        //  Personage selection
        selectPlayerPersonage(currentPlayer: .Player1)
        selectPlayerPersonage(currentPlayer: .Player2)
        
        //return
        
        //  Loop of game
        //  Do not quit while new part is not ended
        //  The end of the game may be due to the fact that:
        //  - One of the two players wins the game
        //  - One of the players decides to stop the game
        //repeat {
        //
        //}while !quit
    }
    
    private func selectPlayerPersonage(currentPlayer: CurrentPlayer) -> Void {
        var totalSelection = 0
        var player: Player

        if currentPlayer == .Player1{
            player = player1
        }else{
            player = player2
        }
        
        print("Choix des personnages de [\(player.name)])")
        
        //  This list is used to handle player personage selection
        //  We will remove the personage selected
        var listOfPersonageToSelection = [Personage]()
        
        var index = 0
        for (_, personage) in Constants.PersonageStore {
            let personageIndex = index + 1
            print("\(personageIndex). \(personage.name)")
            
            listOfPersonageToSelection += [personage]
            index += 1
        }
        
        repeat{
            print("Vos choix : ")
            if let choix = Constants.readInteger(), (choix > 0 && choix <= listOfPersonageToSelection.count) {
                let personage = listOfPersonageToSelection[choix - 1]
                
                editPersonageName(personage: personage)
                
                totalSelection -= 1
            }else{
                print("Choix invalide. Merci de faire un nouveau choix.")
            }
        }while totalSelection < 3
        
    }
    
    private func editPersonageName(personage: Personage) -> Void{
        var nameIsUsed = false
        repeat{
            print("Veuillez saire le nom de votre personnage : ")
            if let name = readLine(){
                personage.name = name.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                nameIsUsed = checkIfNameIsUsed(name: personage.name)
                if nameIsUsed {
                    print("[\(name)] est déjà utilisé. Merci de saisir un autre nom")
                }
            }else{
                print("Nom invalide")
            }
            
        }while personage.name.count <= 0 || nameIsUsed
    }
    
    //  Check if the name is not used in both player list
    private func checkIfNameIsUsed(name: String) -> Bool{
        return checkIfNameIsUsedInPlayer(name: name, player: player1) && checkIfNameIsUsedInPlayer(name: name, player: player2)
    }
    
    //  Check if the name is not used in player list of personage
    private func checkIfNameIsUsedInPlayer(name: String, player: Player) -> Bool{
        var isUsed = false
        
        for personage in player.listOfPersonageSelected {
            if personage.name.lowercased() == name.lowercased() {
                isUsed = true
                break
            }
        }
        
        return isUsed
    }
    
    private func teamDefinition() -> Void {
        //  The players can't have the same name
        repeat{
            definePlayerName(player: player1, defaultName: "Equipe1")
            definePlayerName(player: player2, defaultName: "Equipe2")
            
            if player1.name == player2.name {
                print("Les deux équipes ne peuvent pas porter le même nom\n")
            }
        }while (player1.name == player2.name)
    }
    
    private func definePlayerName(player: Player, defaultName: String) -> Void {
        repeat{
            print("\nEntrez le nom de votre équipe -> \(defaultName): ")
            if let name = readLine() {
                player.name = name
            }
            
            if player.name == "" {
                print("Nom invalide")
            }
        }while player.name.count <= 0
    }
    
    func restartGame() -> Void {
        
    }
}
