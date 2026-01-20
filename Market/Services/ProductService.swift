//
//  ProductService.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Service for getting product data.
final class ProductService {
	static let service = ProductService()
	
	private let apiClient: APIClient
	
	private init(apiClient: APIClient = .shared) {
		self.apiClient = apiClient
	}
	
	/// Fetches a paginated list of products from the API.
	/// - Parameters:
	///   - offset: Number of products to skip.
	///   - limit: Max number of products to return.
	/// - Returns: An array of `Product` models.
	func fetchProducts(skip: Int, limit: Int = 10) async throws -> [Product] {
		let endpoint = Endpoint(
			path: "",
			queryItems: [
				URLQueryItem(name: "skip", value: String(skip)),
				URLQueryItem(name: "limit", value: String(limit))
			]
		)
		let response: ProductResponse = try await apiClient.get(endpoint)
		return response.products
	}
	
	/// Fetches a list of products from a specifc category
	/// - Parameters:
	///   - id: The id of the product.
	/// - Returns: An array of `Product` models.
	func fetchProductsByCategory(categoryName: String) async throws -> [Product] {
		let endpoint = Endpoint(
			path: "category/\(categoryName)"
		)
		
		let response: ProductResponse =  try await apiClient.get(endpoint)
		return response.products
	}
	
	/// Searches through products
	/// - Parameters:
	///   - query: The search query..
	/// - Returns: An array of `Product` models.
	func searchProducts(query: String) async throws -> [Product] {
		let endpoint = Endpoint(
			path: "",
			queryItems: [
				URLQueryItem(name: "q", value: query)
			]
		)
		let response: ProductResponse = try await apiClient.get(endpoint)
		return response.products
	}
}
