//
//  PersonageAttacker.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 05/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class PersonageAttacker: Personage, Attacker {
    private init(name: String, life: Int, weapon: WeaponAttack) {
        super.init(name: name, life: life, weapon: weapon)
    }
    
    func attack(personage: Personage, damage: Int) {
        personage.life = personage.life - damage
        if(personage.life < 0){
            personage.life = 0
        }
    }
}
