//
//  Category.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Category data model from DummyJSON API
struct Category: Codable, Identifiable, Hashable, Equatable {
	let slug: String
	let name: String
	let url: String
	var id: String { slug }
}

