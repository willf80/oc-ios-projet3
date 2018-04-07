//
//  WeaponAttack.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 07/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class WeaponAttack: Weapon {
    var damage: Int
    
    init(name: String, damage: Int) {
        self.damage = damage
        super.init(name: name)
    }
    
}
