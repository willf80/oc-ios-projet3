//
//  WeaponCare.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 07/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class WeaponCare: Weapon {
    var care: Int
    
    init(name: String, care: Int) {
        self.care = care
        super.init(name: name)
    }
}
