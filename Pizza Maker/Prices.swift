//
//  Prices.swift
//  Pizza Maker
//
//  Created by Developer Shishir on 5/25/19.
//  Copyright © 2019 Shishir's App Studio. All rights reserved.
//

import Foundation


enum PizzaSize: Int {
    case regular = 40
    case medium = 60
    case large = 70
    
    var price: Int {
        return self.rawValue
    }
}

enum PizzaType:Int {
    case thinCrust = 50
    case pan = 40
    case chicago = 60
    
    var price: Int {
        return self.rawValue
    }
}


enum Cheese: Int{
    case white = 10
    case brown = 20
    
    var price: Int {
        return self.rawValue
    }
}


enum Sauce: Int {
    case tomato = 20
    case bbq = 15
    case marinara = 30
    
    var price: Int {
        return self.rawValue
    }
}


enum Toppings: Int {
    case onion = 5
    case pepperoni = 30
    case greenPepper, anchovies = 20
    
    
    var price: Int {
        return self.rawValue
    }
}

