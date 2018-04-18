//
//  Personage.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 04/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class Personage {
    var life:Int
    let maxLife:Int
    var name:String
    var pseudoName:String?
    var weapon: Weapon
    
    init(name: String, life:Int, weapon: Weapon) {
        self.name = name
        self.life = life
        self.weapon = weapon
        self.maxLife = life
    }
    
    func isDead() -> Bool {
        return life <= 0
    }
}
