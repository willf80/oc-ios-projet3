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
    private var currentPlayerEnum = CurrentPlayer.Player1
    
    //Define the two players of the game
    private var player1 = Player()
    private var player2 = Player()
    
    //  Indicates whether the game is over or not
    private var quit = false
    
    //Initialize players data and set player1 current player
    private func initialize() -> Void {
        player1 = Player()
        player2 = Player()
        currentPlayerEnum = CurrentPlayer.Player1
    }
    
    //  Show credits option menu
    func credits() -> Void {
        print("\n=================== CREDITS ===================")
        print("Développé par WILLY FALONE KOUADIO")
        print("Mentoré par Jean-Michel ZARAGOZA")
        print("--- Merci à toute l'équipe OpenClassrooms ! ---")
        print("===============================================\n\n")
    }
    
    func startNewGame() -> Void {
        initialize()
        
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
    
    //This make game in pause
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
            let currentPlayerSelected = getCurrentPlayer(currentPlayer: self.currentPlayerEnum)
            let oppositePlayer = getTheOppositePlayer()
            
            //Give the list of the characters of the opposing team with the useful properties, so that the player can make an informed choice!
            print("\n\n******* Au tour de l'équipe [\(currentPlayerSelected.name)] *******")
            oppositePlayer.showTeamListWithDetails()
            
            print("\nVeillez selectionner un personnage [\(currentPlayerSelected.name)] : ")
            currentPlayerSelected.showTeamListWithDetails()
            
            
            //Select current player personage
            var playerPersonageSelectedForAttackOrCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.listOfPersonageSelected)
            if playerPersonageSelectedForAttackOrCare.isDead(){
                repeat{
                    print("Le personnage est mort. Choisissez un autre")
                    playerPersonageSelectedForAttackOrCare = takeCurrentPlayerPersonage(listOfPersonage: currentPlayerSelected.listOfPersonageSelected)
                }while playerPersonageSelectedForAttackOrCare.isDead()
            }
            
            //Check if we can show weapon suggestion
            showSuggestion(personage: playerPersonageSelectedForAttackOrCare)
            
            //Check if is Attacker or Healer
            //--------------------------------------
            //If is Healer, we show current player personage
            if playerPersonageSelectedForAttackOrCare is PersonageHealer{
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
                print("-----------------------------")
                print("**** Bravo \(currentPlayerSelected.name) ! Vous avez remporté la partie ****")
                print("**** Statistiques ****")
                print("**** \(currentPlayerSelected.name) = \(currentPlayerSelected.numberOfLaps) tour(s) ****")
                print("**** \(oppositePlayer.name) = \(oppositePlayer.numberOfLaps) tour(s) ****")
                print("=============================")
                quit = true
            }else{
                currentPlayerSelected.numberOfLaps += 1
                //Toggle player
                currentPlayerEnum.nextPlayer()
            }
            
            makePause()
            
        }while !quit
    }
    
    private func showSuggestion(personage: Personage) -> Void {
        if Constants.random(max: 1) > 0 {
            print("Un coffre est disponible. Voulez-vous l'ouvrir ?")
            print("1 -> Ouvrir le coffre")
            print("X -> Ne pas utiliser le coffre")
            print("Votre choix : ")
            
            if let response = readLine(), response == "1" {
                let indexWeapon = Constants.random(max: Constants.WeaponStore.count - 1)
                var weaponRandom : Weapon?
                
                var i = 0
                for (_, value) in Constants.WeaponStore {
                    if i == indexWeapon{
                        weaponRandom = value
                        break
                    }
                    
                    i += 1
                }
                
                if let weapon = weaponRandom{
                    var text = "-> Le coffre contient une arme"
                    
                    if weapon is WeaponAttack{
                        let _weapon = weapon as! WeaponAttack
                        text += " [\(_weapon.name) : \(_weapon.damage)] de type ATTAQUE"
                    }else{
                        let _weapon = weapon as! WeaponCare
                        text += " [\(_weapon.name) : \(_weapon.care)] de type SOIN"
                    }
                    
                    print(text)
                    
                    var canGiveWeapon = false
                    if (personage is PersonageHealer) && (weapon is WeaponCare){
                        canGiveWeapon = true
                    }else if (personage is PersonageAttacker) && (weapon is WeaponAttack) {
                        canGiveWeapon = true
                    }else{
                        print("-> Cette arme ne peut être utilisée par votre personnage.")
                    }
                    
                    if canGiveWeapon {
                        print("Voulez-vous utiliser cette arme ? ")
                        print("1 -> Utiliser l'arme")
                        print("X -> Abandonner l'arme")
                        print("Votre choix : ")
                        
                        if let weaponSelectedResponse = readLine(), weaponSelectedResponse == "1" {
                            personage.weapon = weapon
                        }else{
                            print("-> Arme abandonnée !")
                        }
                    }
                }
                
            }else{
                print("-> Coffre non utilisé")
            }
        }
    }
    
    //Get the opposite player.
    //If current player is player1, it return player2
    private func getTheOppositePlayer() -> Player {
        if currentPlayerEnum == .Player1{
            return player2
        }else{
            return player1
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
        var listOfPersonageToSelection = Constants.getAllPersonageStore()
        
        var index = 0
        for personage in listOfPersonageToSelection {
            
            var text = ""
            if personage.weapon is WeaponAttack{
                let weaponAttack = personage.weapon as! WeaponAttack
                text = "\(index+1). \(personage.name) [Vie : \(personage.life), \(weaponAttack.name) : \(weaponAttack.damage)]"
            }else{
                let weaponCare = personage.weapon as! WeaponCare
                text = "\(index+1). \(personage.name) [Vie : \(personage.life), \(weaponCare.name) : \(weaponCare.care)]"
            }
            
            print(text)
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
            print("Veuillez saisire le nom de votre personnage : ")
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
