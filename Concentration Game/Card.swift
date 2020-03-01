//
//  Card.swift
//  Playing Card
//
//  Created by Mohamed Saidi on 10/16/19.
//  Copyright © 2019 Mohamed Saidi. All rights reserved.
//

import Foundation
struct Card {
    //MARK: Proprities
    var identifier: Int
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    var isFaceUp = false
    var isMatched = false
    //MARK: Init
    init() {
        
        identifier = Card.getUniqueIdentifier()
    }
    
    
}
extension Card: Equatable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
        
    }
}
