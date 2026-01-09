//
//  Item.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
