//
//  Category.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Category data model from Platzi API
struct Category: Codable, Identifiable, Hashable, Equatable {
	let id: Int
	let name: String
	let image: String
	let slug: String
}

