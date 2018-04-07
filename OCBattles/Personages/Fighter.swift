//
//  Fighter.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 05/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class Fighter: PersonageAttacker {
    init(name:String) {
        super.init(name: name, life: 100, weapon: Constants.WeaponStore[WeaponNameID.EPEE.rawValue] as! WeaponAttack)
    }
}
