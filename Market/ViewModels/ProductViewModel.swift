//
//  ProductViewModel.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

@Observable
final class ProductViewModel {
	
	// UI State
	var products: [Product] = []
	var isLoading: Bool = false
	var isLoadingMore: Bool = false
	var errorMessage: String? = nil
	
	// Pagination
	private var offset: Int = 0
	private let limit: Int
	
	private let service: ProductService
	
	private var hasMore: Bool = true
	
	init(service: ProductService, limit: Int = 10) {
		self.service = service
		self.limit = limit
	}
	
	/// Refreshes the list
	func refresh() async throws {
		isLoading = true
		errorMessage = nil
		
		offset = 0
		hasMore = true
		products.removeAll(keepingCapacity: true)
		
		defer {isLoading = false}
		
		do {
			let firstPage = try await service.fetchProducts(offset: offset, limit: limit)
			products = firstPage
			offset += firstPage.count
			hasMore = firstPage.count == limit
		} catch {
			errorMessage = error.localizedDescription
		}
	}
	
	/// Check if we need to load more.
	func loadMoreIfNeeded(currentItem: Product?) async {
		guard let currentItem else {return}
		guard hasMore, !isLoading, !isLoadingMore else {return}
		
		let threshold = 3
		guard let index = products.firstIndex(where: {$0.id == currentItem.id }) else { return }
		let shouldLoadMore = index >= products.count - threshold
		guard shouldLoadMore else { return }
		
		await loadMore()
	}
	
	/// Loads more products.
	private func loadMore() async {
		isLoadingMore = true
		errorMessage = nil
		
		defer {isLoadingMore = false}
		
		do {
			let nextPage = try await service.fetchProducts(offset: offset, limit: limit)
			products.append(contentsOf: nextPage)
			offset += nextPage.count
			hasMore = nextPage.count == limit
		} catch {
			errorMessage = error.localizedDescription
		}
	}

}
