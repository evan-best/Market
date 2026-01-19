//
//  ProductDetailViewModel.swift
//  Market
//
//  Created by Evan Best on 2026-01-12.
//

import Foundation

@Observable
final class ProductDetailViewModel {
	private let service = ProductService.service

	var relatedProducts: [Product] = []
	var errorMessage: String? = nil
	var isLoading: Bool = false

	func loadFromCategory(for category: String) async {
		isLoading = true
		errorMessage = nil
		defer { isLoading = false }

		do {
			relatedProducts = try await service.fetchProductsByCategory(categoryName: category)
		} catch {
			errorMessage = error.localizedDescription
			relatedProducts = []
		}
	}
}

