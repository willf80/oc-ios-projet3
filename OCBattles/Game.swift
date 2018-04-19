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
    private var currentPlayer = CurrentPlayer.Player1
    
    private let player1 = Player()
    private let player2 = Player()
    
    //  Indicates whether the game is over or not
    private var quit = false
    
    func startNewGame() -> Void {
        
        print("\n\n============= DEFINITION DES EQUIPES =============")
        
        //  Define player name
       teamDefinition()
        
        print("\n\n============= CHOIX DES PERSONNAGES =============")
        //  Personage selection
        selectPlayerPersonage(currentPlayer: .Player1)
        selectPlayerPersonage(currentPlayer: .Player2)
        
        makePause()
        
        print("\n\n============= COMBAT =============")
        goInCombat()
    }
    
    private func makePause() -> Void{
        print("\nAppuyer sur entrer pour continuer...")
        _ = readLine() //Just to put application in pause
    }
    
    private func goInCombat() -> Void {
        //  Loop of game
        //  Do not quit while new part is not ended
        //  The end of the game may be due to the fact that:
        //  - One of the two players wins the game
        //  - One of the players decides to stop the game
        repeat {
            let currentPlayerSelected = getCurrentPlayer(currentPlayer: self.currentPlayer)
            let oppositePlayer = getTheOppositePlayer()
            
            //Give the list of the characters of the opposing team with the useful properties, so that the player can make an informed choice!
            print("\n\n******* Au tour de l'équipe [\(currentPlayerSelected.name)] *******")
            oppositePlayer.showTeamListWithDetails()
            
            print("\nVeillez selectionner un personnage [\(currentPlayerSelected.name)] : ")
            currentPlayerSelected.showTeamListWithDetails()
            
            var playerPersonageSelectedForAttackOrCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.listOfPersonageSelected)
            if playerPersonageSelectedForAttackOrCare.isDead(){
                repeat{
                    print("Le personnage est mort. Choisissez un autre")
                    playerPersonageSelectedForAttackOrCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.listOfPersonageSelected)
                }while playerPersonageSelectedForAttackOrCare.isDead()
            }
            
            //Check if is Attacker or Healer
            //--------------------------------------
            //If is Healer, we show current player personage
            if playerPersonageSelectedForAttackOrCare is Healer{
                let personageHealer = playerPersonageSelectedForAttackOrCare as! PersonageHealer
                
                //Show player list without Mage
                //Because the mage can not heal himself or another mage
                currentPlayerSelected.showTeamListWithoutHealer(headerMessage: "Liste des personnages à soigner de [\(currentPlayerSelected.name)] : ")
                
                //Check if personage to care is not dead
                var personageToCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.getPersonageWithoutHealer())
                if(personageToCare.isDead()){
                    repeat{
                        print("Le personnage est mort. Choisissez un autre")
                        personageToCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.getPersonageWithoutHealer())
                    }while personageToCare.isDead()
                }
                
                //Get personage healer weapon
                let weaponCare = personageHealer.weapon as! WeaponCare
                personageHealer.cure(personage: personageToCare, giveCare: weaponCare.care)
                
                print("\n-> \(personageHealer.pseudoName!) à soigné \(personageToCare.pseudoName!) avec un(e) \(weaponCare.name) de \(weaponCare.care) vies\n")
                
                //Show recap
                currentPlayerSelected.showTeamListWithDetails()
            }else{
                let personageAttacker = playerPersonageSelectedForAttackOrCare as! PersonageAttacker
                
                //Show opposite player list
                oppositePlayer.showTeamListWithDetails(headerMessage: "Liste des personnages à attacker de [\(oppositePlayer.name)] : ")
                
                var personageAttacked = takeCurrentPlayerPersonage(listOfPersonage: oppositePlayer.listOfPersonageSelected)
                if(personageAttacked.isDead()){
                    repeat{
                        print("Le personnage est mort. Choisissez un autre")
                        personageAttacked = takeCurrentPlayerPersonage(listOfPersonage: oppositePlayer.listOfPersonageSelected)
                    }while personageAttacked.isDead()
                }
                
                //Get personage attacker weapon
                let weaponAttack = personageAttacker.weapon as! WeaponAttack
                personageAttacker.attack(personage: personageAttacked, damage: weaponAttack.damage)
                
                print("\n-> \(personageAttacker.pseudoName!) a attacké(e) \(personageAttacked.pseudoName!) avec un(e) \(weaponAttack.name). \(weaponAttack.damage) vies retirée\n")
                
                //Show recap
                oppositePlayer.showTeamListWithDetails()
            }
            
            if oppositePlayer.isAllPersonageAreDead() {
                print("\n\n=============================")
                print("l'équipe [\(oppositePlayer.name)] à perdue tous ces personnages !")
                print("**** Bravo \(currentPlayerSelected.name) ! Vous avez remporté la partie ****")
                print("=============================")
                quit = true
            }
            
            //Toggle player
            toggleCurrentPlayer()
            makePause()
        }while !quit
    }
    
    private func getTheOppositePlayer() -> Player {
        if currentPlayer == .Player1{
            return player2
        }else{
            return player1
        }
    }
    
    private func toggleCurrentPlayer() -> Void {
        if currentPlayer == .Player1{
            currentPlayer = .Player2
        }else{
            currentPlayer = .Player1
        }
    }
    
    private func takeCurrentPlayerPersonage(listOfPersonage: [Personage]) -> Personage {
        var choice = 0
        repeat{
            print("Votre choix : ")
            if let input = Constants.readInteger() {
                choice = input
            }else{
                print("Choix invalide !")
            }
        }while choice <= 0 || choice > listOfPersonage.count
        
        return listOfPersonage[choice - 1]
    }
    
//    private func recapitulationPlayersList() -> Void {
//        print("\nListe des équipes")
//        print("#############################\n")
//
//        print("Equipe \(player1.name)")
//        player1.showTeamListWithDetails()
//        print("")
//
//        print("Equipe \(player2.name)")
//        player2.showTeamListWithDetails()
//    }
    
    private func getCurrentPlayer(currentPlayer: CurrentPlayer) -> Player {
        var player: Player
        
        if currentPlayer == .Player1{
            player = player1
        }else{
            player = player2
        }
        
        return player
    }
    
    private func selectPlayerPersonage(currentPlayer: CurrentPlayer) -> Void {
        var totalSelection = 0
        
        let player = getCurrentPlayer(currentPlayer: currentPlayer)
        
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
        
        player.showTeamListWithDetails()
    }
    
    private func editPersonageName(personage: Personage) -> Void{
        var nameIsUsed = false
        repeat{
            print("Veuillez saire le nom de votre personnage : ")
            if let pseudoName = readLine(){
                personage.pseudoName = pseudoName.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                nameIsUsed = checkIfPseudoNameIsUsed(pseudoName: personage.pseudoName!)
                if nameIsUsed {
                    print("[\(pseudoName)] est déjà utilisé.")
                }
            }else{
                print("Nom invalide")
            }
            
        }while personage.pseudoName!.count <= 0 || nameIsUsed
    }
    
    //  Check if the name is not used in both player list
    private func checkIfPseudoNameIsUsed(pseudoName: String) -> Bool{
        return checkIfPseudoNameIsUsedInPlayer(pseudoName: pseudoName, player: player1) ||
            checkIfPseudoNameIsUsedInPlayer(pseudoName: pseudoName, player: player2)
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
}
