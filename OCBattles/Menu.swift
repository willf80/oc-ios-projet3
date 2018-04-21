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
    var quitGame = false
    
    //  This function is called to show game menu
    //  Entry point
    func showHomeMenu() -> Void {
        
        //  Creating the game menu
        repeat{
            print("########### Bienvenue ! ###########")
            print("Veuillez selectionner l'action à effectuer.")
            print("1. Nouvelle partie")
            print("2. Crédits")
            print("3. Quitter")
            
            //  Choose the option we want
            //  While the choice is invalid, we repeat the action
            var userChoice = 0
            
            repeat{
                print("Votre choix : ")
                if let choice = Constants.readInteger() {
                    userChoice = choice
                }else{
                    print("Choix invalide !")
                }
            }while (userChoice <= 0 || userChoice > 3)
            
            //  Do the action of choice
            switch userChoice {
            case 1:
                game.startNewGame()
                break
            case 2:
                //Game credits
                game.credits()
                break
                
            case 3:
                //  Quit the game
                quitGame = true
                break
            default:
                break
            }
        }while !quitGame
        
        print("Au revoir !")
    }
}
