//
//  CategoryViewModel.swift
//  Market
//
//  Created by Evan Best on 2026-01-11.
//

import Foundation

@Observable
final class CategoryViewModel {
	private let service: CategoryService = .shared

	var categories: [Category] = []
	var isLoading: Bool = false
	var errorMessage: String? = nil

	/// Loads categories from the API.
	func loadCategories() async {
		guard !isLoading else { return }

		isLoading = true
		errorMessage = nil
		defer { isLoading = false }

		do {
			let fetched = try await service.getCategories()

			self.categories = fetched.filter { category in
				let name = category.name.lowercased()
				let slug = category.slug.lowercased()
				let image = category.image.lowercased()

				if name == "string" { return false }
				if name.contains("category") { return false }
				if slug.contains("category") { return false }
				if image.contains("pravatar.cc") { return false }

				return true
			}
		} catch {
			self.errorMessage = "Couldn’t load categories. \(error.localizedDescription)"
		}
	}
}

