//
//  Mage.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 05/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

class Mage: PersonageHealer {
    init(name:String) {
        super.init(name: name, life: 120, weapon: Constants.WeaponStore[WeaponNameID.CARE_SHEET.rawValue] as! WeaponCare)
    }
}
