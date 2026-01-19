//
//  Review.swift
//  Market
//
//  Created by Evan Best on 2026-01-17.
//

import Foundation

struct Review: Codable, Hashable {
	let rating: Int
	let comment: String
	let date: Date
	let reviewerName: String
	let reviewerEmail: String
}
