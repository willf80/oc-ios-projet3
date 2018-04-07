//
//  PersonageHealer.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 05/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class PersonageHealer: Personage, Healer {
    init(name: String, life: Int, weapon: WeaponCare) {
        super.init(name: name, life: life, weapon: weapon)
    }
    
    func cure(personage: Personage, giveCare care: Int) {
        personage.life = personage.life + care
        if(personage.life > personage.maxLife){
            personage.life = personage.maxLife
        }
    }
}
