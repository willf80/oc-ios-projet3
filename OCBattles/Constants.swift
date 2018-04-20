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
    case MICROBE = "MICROBE"
    case POISON = "POISON"
    case POWDER_OF_LIFE = "POWDER_OF_LIFE"
}

struct Constants {
    //  Define all available weapons
    static let WeaponStore = [WeaponID.EPEE.rawValue : WeaponAttack(name: "Epée", damage: 10),
                              WeaponID.CARE_SHEET.rawValue : WeaponCare(name: "Feuille de soin", care: 12),
                              WeaponID.CUDGEL.rawValue : WeaponAttack(name: "Gourdin", damage: 8),
                              WeaponID.MICROBE.rawValue : WeaponAttack(name: "Poignard-machette", damage: 17),
                              WeaponID.POISON.rawValue : WeaponAttack(name: "Poison", damage: 13),
                              WeaponID.POWDER_OF_LIFE.rawValue : WeaponCare(name: "Poudre de vie", care: 15),
                              WeaponID.AXE.rawValue : WeaponAttack(name: "Hache", damage: 15)]
    
    //  Definition of all personages without their pseudoName
    static func getAllPersonageStore() -> [Personage] {
        return [PersonageAttacker(name: "Combattant", life: 100, weapon: WeaponStore[WeaponID.EPEE.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Colosse", life: 110, weapon: WeaponStore[WeaponID.CUDGEL.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Nain", life: 50, weapon: WeaponStore[WeaponID.AXE.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Microbe", life: 90, weapon: WeaponStore[WeaponID.MICROBE.rawValue] as! WeaponAttack),
               PersonageAttacker(name: "Assain", life: 90, weapon: WeaponStore[WeaponID.POISON.rawValue] as! WeaponAttack),
               PersonageHealer(name: "Mage", life: 40, weapon: WeaponStore[WeaponID.CARE_SHEET.rawValue] as! WeaponCare),
               PersonageHealer(name: "Guerisseur", life: 60, weapon: WeaponStore[WeaponID.POWDER_OF_LIFE.rawValue] as! WeaponCare)
        ]
    }
    
    //  Read integer line
    static func readInteger() -> Int? {
        var input :Int?
        
        if let userInput = readLine(), let _input = Int(userInput) {
            input = _input
        }
        
        return input
    }
    
    static func random(max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max + 1)))
    }
}
