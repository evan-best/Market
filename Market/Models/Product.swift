//
//  Product.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Product data model from Platzi API
struct Product: Codable, Identifiable, Hashable {
	let id: Int
	let title: String
	let slug: String
	let price: Double
	let description: String
	let category: Category
	let images: [String]
}

