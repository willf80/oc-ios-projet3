//
//  Menu.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 03/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

//  Create game menu
class Menu {
    let game = Game()
    
    //  This function is called to show game menu
    //  Entry point
    func showHomeMenu() -> Void {
        //  Creating the game menu
        print("Bienvenue !\n")
        print("Veuillez selectionner l'action à effectuer.\n")
        print("1. Nouvelle partie\n")
        print("2. Crédits\n")
        print("3. Quitter\n\n")
        
        //  Choose the option we want
        //  While the choice is invalid, we repeat the action
        var userChoice = 0
        
        repeat{
            print("Votre choix : ")
            if let userInput = readLine(), let choice = Int(userInput) {
                userChoice = choice
            }
        }while (userChoice <= 0 || userChoice > 3)
        
        //  Do the action of choice
        switch userChoice {
        case 1:
            game.startNewGame()
            break
        case 2:
            //  TODO: Game credits
            break
            
        case 3:
            //  TODO: Quit the game
            break
        default:
            break
        }
    }
}
