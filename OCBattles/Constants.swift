//
//  Constants.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 04/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

//All IDs of the weapons to make the source code easily readable
enum WeaponNameID: String{
    case EPEE = "EPEE"
    case CARE_SHEET = "CARE_SHEET"
    case CUDGEL = "CUDGEL"
    case AXE = "AXE"
}

class Constants {
    //  Define all available weapons
    static let WeaponStore = [WeaponNameID.EPEE.rawValue : WeaponAttack(name: "Epée", damage: 10),
                              WeaponNameID.CARE_SHEET.rawValue : WeaponCare(name: "Feuille de soin", care: 6),
                              WeaponNameID.CUDGEL.rawValue : WeaponAttack(name: "Gourdin", damage: 3),
                              WeaponNameID.AXE.rawValue : WeaponAttack(name: "Hache", damage: 7)]
    
    //  Read integer line
    static func readInteger() -> Int? {
        var input :Int?
        
        if let userInput = readLine(), let _input = Int(userInput) {
            input = _input
        }
        
        return input
    }
    
}
