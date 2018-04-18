//
//  Constants.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 04/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

//  All IDs of the weapons to make the source code easily readable
enum WeaponID: String{
    case EPEE = "EPEE"
    case CARE_SHEET = "CARE_SHEET"
    case CUDGEL = "CUDGEL"
    case AXE = "AXE"
}

struct Constants {
    //  Define all available weapons
    static let WeaponStore = [WeaponID.EPEE.rawValue : WeaponAttack(name: "Epée", damage: 10),
                              WeaponID.CARE_SHEET.rawValue : WeaponCare(name: "Feuille de soin", care: 8),
                              WeaponID.CUDGEL.rawValue : WeaponAttack(name: "Gourdin", damage: 5),
                              WeaponID.AXE.rawValue : WeaponAttack(name: "Hache", damage: 15)]
    
    //  Definition of all personages without their pseudoName
    static func getAllPersonageStore() -> [Personage] {
        return [PersonageAttacker(name: "Combattant", life: 100, weapon: WeaponStore[WeaponID.EPEE.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Colosse", life: 190, weapon: WeaponStore[WeaponID.CUDGEL.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Nain", life: 60, weapon: WeaponStore[WeaponID.AXE.rawValue] as! WeaponAttack),
               PersonageHealer(name: "Mage", life: 120, weapon: WeaponStore[WeaponID.CARE_SHEET.rawValue] as! WeaponCare)]
    }
    
    //  Read integer line
    static func readInteger() -> Int? {
        var input :Int?
        
        if let userInput = readLine(), let _input = Int(userInput) {
            input = _input
        }
        
        return input
    }
    
    
}
