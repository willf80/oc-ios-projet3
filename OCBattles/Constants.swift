//
//  Constants.swift
//  OCBattles
//
//  Created by WILLY Falone Kouadio on 04/04/2018.
//  Copyright © 2018 WILLY Falone Kouadio. All rights reserved.
//

import Foundation

//
class Constants {
    
    //  Read integer line
    static func readInteger() -> Int? {
        var input :Int?
        
        if let userInput = readLine(), let _input = Int(userInput) {
            input = _input
        }
        
        return input
    }
}
