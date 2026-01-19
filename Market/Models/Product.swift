//
//  Product.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Wrapper for paginated product responses from DummyJSON API
struct ProductResponse: Codable {
	let products: [Product]
	let total: Int
	let skip: Int
	let limit: Int
}

/// Product data model from DummyJSON API
struct Product: Codable, Identifiable, Hashable {
	let id: Int
	let title: String
	let description: String
	let category: String
	let price: Double
	let discountPercentage: Double
	let rating: Double
	let stock: Int
	let tags: [String]
	let brand: String?
	let sku: String
	let dimensions: Dimensions
	let warrantyInformation: String
	let shippingInformation: String
	let reviews: [Review]
	let returnPolicy: String
	let minimumOrderQuantity: Int
	let thumbnail: String
	let images: [String]
}

