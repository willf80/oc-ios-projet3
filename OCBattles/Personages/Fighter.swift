//
//  Fighter.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 05/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class Fighter: Personage, Attacker {
    
    init(name:String) {
        super.init(name: name, life: 100, weapon: Weapon(name: "Epée", damage: 10))
    }
    
    func attack(personage: Personage, damage: Int) {
        
    }
}
