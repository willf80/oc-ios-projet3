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
        
        print("Appuyer sur entrer pour afficher le recapitulatif des équipes...")
        _ = readLine() //Just to put application in pause
        recapitulationPlayersList()
        
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
    
    func recapitulationPlayersList() -> Void {
        print("\nListe des équipes")
        print("#############################\n")
        
        print("Equipe \(player1.name)")
        showPlayerPersonageList(player: player1)
        
        print("")
        
        print("Equipe \(player2.name)")
        showPlayerPersonageList(player: player2)
    }
    
    private func showPlayerPersonageList(player: Player) -> Void{
        print("------------------")
        print("Liste des combattants de l'équipe [\(player.name)]")
        for i in 0..<player.listOfPersonageSelected.count {
            let personage = player.listOfPersonageSelected[i]
            
            if personage.weapon is WeaponAttack{
                let weaponAttack = personage.weapon as! WeaponAttack
                print("\(i+1). \(personage.pseudoName!) [Vie = \(personage.life), Arme = \(weaponAttack.name), Dommage = \(weaponAttack.damage)]")
            }else{
                let weaponCare = personage.weapon as! WeaponCare
                print("\(i+1). \(personage.pseudoName!) [Vie = \(personage.life), Arme = \(weaponCare.name), Soin = \(weaponCare.care)]")
            }
        }
    }
    
    private func selectPlayerPersonage(currentPlayer: CurrentPlayer) -> Void {
        var totalSelection = 0
        var player: Player

        if currentPlayer == .Player1{
            player = player1
        }else{
            player = player2
        }
        
        print("\n------------------\n")
        print("Choix des personnages de [\(player.name)]")
        
        //  This list is used to handle player personage selection
        //  We will remove the personage selected
        var listOfPersonageToSelection = [Personage]()
        
        var index = 0
        for personage in Constants.getAllPersonageStore() {
            print("\(index + 1). \(personage.name)")
            listOfPersonageToSelection += [personage]
            index += 1
        }
        
        repeat{
            print("Saisissez votre choix N°\(totalSelection + 1): ")
            if let choix = Constants.readInteger(), (choix > 0 && choix <= listOfPersonageToSelection.count) {
                let personage = listOfPersonageToSelection[choix - 1]
                editPersonageName(personage: personage)
                
                player.listOfPersonageSelected += [personage]
                totalSelection += 1
            }else{
                print("Choix invalide. Merci de faire un nouveau choix.")
            }
        }while totalSelection < 3
        
        showPlayerPersonageList(player: player)
    }
    
    private func editPersonageName(personage: Personage) -> Void{
        var nameIsUsed = false
        repeat{
            print("Veuillez saire le nom de votre personnage : ")
            if let pseudoName = readLine(){
                personage.pseudoName = pseudoName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                nameIsUsed = checkIfPseudoNameIsUsed(pseudoName: personage.pseudoName!)
                if nameIsUsed {
                    print("[\(pseudoName)] est déjà utilisé. Merci de saisir un autre nom")
                }
            }else{
                print("Nom invalide")
            }
            
        }while personage.pseudoName!.count <= 0 || nameIsUsed
    }
    
    //  Check if the name is not used in both player list
    private func checkIfPseudoNameIsUsed(pseudoName: String) -> Bool{
        return checkIfPseudoNameIsUsedInPlayer(pseudoName: pseudoName, player: player1) && checkIfPseudoNameIsUsedInPlayer(pseudoName: pseudoName, player: player2)
    }
    
    //  Check if the name is not used in player list of personage
    private func checkIfPseudoNameIsUsedInPlayer(pseudoName: String, player: Player) -> Bool{
        var isUsed = false
        
        for personage in player.listOfPersonageSelected {
            if personage.pseudoName!.lowercased() == pseudoName.lowercased() {
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
