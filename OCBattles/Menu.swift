//
//  Menu.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 03/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

class Menu {
    //  Create game menu
    //  Show player status
    
    func showHomeMenu() -> Void {
        //  Creating the game menu
        print("Bienvenue !\n")
        print("Veuillez selectionner l'action à effectuer.\n")
        print("1. Nouvelle partie\n")
        print("2. Meilleurs scores\n")
        print("3. Crédits\n\n")
        
        //  Choose the option we want
        //  While the choice is invalid, we repeat the action
        var userChoice = 0
        
        repeat{
            print("Votre choix : ")
            if let userInput = readLine(), let choice = Int(userInput) {
                userChoice = choice
            }
        }while (userChoice <= 0 || userChoice > 2)
        
        
        //  TODO : Do the action of choice
        
    }
}
