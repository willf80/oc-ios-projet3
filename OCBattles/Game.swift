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
        
        //  Define player name
       teamDefinition()
        
        //  Personage selection
        selectPlayerPersonage(currentPlayer: .Player1)
        selectPlayerPersonage(currentPlayer: .Player2)
        
        makePause()
        recapitulationPlayersList()
        
        print("\n\n============= COMBAT =============")
        goInCombat()
    }
    
    func makePause() -> Void{
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
            let currentPlayer = selectCurrentPlayer(currentPlayer: self.currentPlayer)
            let oppositePlayer = determinationOfTheOppositePlayer()
            
            //Give the list of the characters of the opposing team with the useful properties, so that the player can make an informed choice!
            print("\n\n******* Au tour de l'équipe [\(currentPlayer.name)] *******")
            showPlayerPersonageList(player: oppositePlayer)
            
            print("\nVeillez selectionner un personnage [\(currentPlayer.name)] : ")
            showPlayerPersonageList(player: currentPlayer)
            
            let playerPersonageSelectedForAttackOrCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayer.listOfPersonageSelected)
            
            //Check if is Attacker or Healer
            //--------------------------------------
            //If is Healer, we show current player personage
            if playerPersonageSelectedForAttackOrCare is Healer{
                let personageHealer = playerPersonageSelectedForAttackOrCare as! PersonageHealer
                
                //Show player list without Mage
                //Because the mage can not heal himself or another mage
                showPlayerPersonageList(listOfPersonage: currentPlayer.getPersonageWithoutHealer(), title: "Liste des personnes à soigner de [\(currentPlayer.name)] : ")
                
                //Check if personage to care is not dead
                var personageToCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayer.getPersonageWithoutHealer())
                if(personageToCare.isDead()){
                    print("Le personage est mort. Choisissez un autre")
                    repeat{
                        personageToCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayer.getPersonageWithoutHealer())
                    }while personageToCare.isDead()
                }
                
                //Get personage healer weapon
                let weaponCare = personageHealer.weapon as! WeaponCare
                personageHealer.cure(personage: personageToCare, giveCare: weaponCare.care)
                
                print("\n-> \(personageHealer.pseudoName!) à soigné \(personageToCare.pseudoName!) de \(weaponCare.care) vies\n")
                
                //Show recap
                showPlayerPersonageList(player: currentPlayer)
            }else{
                let personageAttacker = playerPersonageSelectedForAttackOrCare as! PersonageAttacker
                
                //Show opposite player list
                showPlayerPersonageList(listOfPersonage: currentPlayer.listOfPersonageSelected, title: "Liste des personnes à attacker de [\(oppositePlayer.name)] : ")
                var personageAttacked = takeCurrentPlayerPersonage(listOfPersonage: oppositePlayer.listOfPersonageSelected)
                if(personageAttacked.isDead()){
                    print("Le personage est mort. Choisissez un autre")
                    repeat{
                        personageAttacked = takeCurrentPlayerPersonage(listOfPersonage: oppositePlayer.listOfPersonageSelected)
                    }while personageAttacked.isDead()
                }
                
                //Get personage attacker weapon
                let weaponAttack = personageAttacker.weapon as! WeaponAttack
                personageAttacker.attack(personage: personageAttacked, damage: weaponAttack.damage)
                
                print("\n-> \(personageAttacker.pseudoName!) a attacké(e) \(personageAttacked.pseudoName!) avec \(weaponAttack.name). \(weaponAttack.damage) vies retirée\n")
                
                //Show recap
                showPlayerPersonageList(player: oppositePlayer)
            }
            
            if oppositePlayer.isAllPersonageAreDead() {
                print("l'équipe [\(oppositePlayer.name)] à perdue tous ces personnages !")
                print("**** Bravo \(currentPlayer.name) ! Vous avez remporté la partie ****")
                quit = true
            }
            
            //Toggle player
            toggleCurrentPlayer()
            makePause()
        }while !quit
    }
    
    private func determinationOfTheOppositePlayer() -> Player {
        if currentPlayer == .Player1{
            return player2
        }else{
            return player1
        }
    }
    
    func toggleCurrentPlayer() -> Void {
        if currentPlayer == .Player1{
            currentPlayer = .Player2
        }else{
            currentPlayer = .Player1
        }
    }
    
    func takeCurrentPlayerPersonage(listOfPersonage: [Personage]) -> Personage {
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
    
    private func recapitulationPlayersList() -> Void {
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
        print("Liste de l'équipe [\(player.name)]")
        for i in 0..<player.listOfPersonageSelected.count {
            let personage = player.listOfPersonageSelected[i]
            
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
    
    private func showPlayerPersonageList(listOfPersonage: [Personage], title: String) -> Void{
        print("------------------")
        print(title)
        print("")
        for i in 0..<listOfPersonage.count {
            let personage = listOfPersonage[i]
            
            if personage.weapon is WeaponAttack{
                let weaponAttack = personage.weapon as! WeaponAttack
                print("\(i+1). \(personage.pseudoName!) [Vie : \(personage.life), \(weaponAttack.name) : \(weaponAttack.damage)]")
            }else{
                let weaponCare = personage.weapon as! WeaponCare
                print("\(i+1). \(personage.pseudoName!) [Vie : \(personage.life), \(weaponCare.name) : \(weaponCare.care)]")
            }
        }
    }
    
    func selectCurrentPlayer(currentPlayer: CurrentPlayer) -> Player {
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
        
        let player = selectCurrentPlayer(currentPlayer: currentPlayer)
        
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
        return checkIfPseudoNameIsUsedInPlayer(pseudoName: pseudoName, player: player1) &&
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
