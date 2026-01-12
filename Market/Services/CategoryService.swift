//
//  CategoryService.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// Service for getting category data.
final class CategoryService {
	static let shared = CategoryService(apiClient: APIClient.shared)

	private let apiClient: APIClient
	
	private init(apiClient: APIClient) {
		self.apiClient = apiClient
	}
	
	/// Get all categories
	/// - Returns: An array of `Category` models.
	func getCategories() async throws -> [Category] {
		let endpoint = Endpoint(path: "categories")
		return try await apiClient.get(endpoint)
	}
}
