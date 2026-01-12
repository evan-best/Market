//
//  ProductService.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Service for getting product data.
final class ProductService {
	static let shared = ProductService(apiClient: .shared)
	
	private let apiClient: APIClient

	private init(apiClient: APIClient) {
		self.apiClient = apiClient
	}

	/// Fetches a paginated list of products from the API.
	/// - Parameters:
	///   - offset: Number of products to skip.
	///   - limit: Max number of products to return.
	/// - Returns: An array of `Product` models.
	func fetchProducts(offset: Int, limit: Int = 10) async throws -> [Product] {
		let endpoint = Endpoint(
			path: "products",
			queryItems: [
				URLQueryItem(name: "offset", value: String(offset)),
				URLQueryItem(name: "limit", value: String(limit))
			]
		)

		return try await apiClient.get(endpoint)
	}
}
