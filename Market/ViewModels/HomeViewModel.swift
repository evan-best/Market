//
//  HomeViewModel.swift
//  Market
//
//  Created by Evan Best on 2026-01-19.
//

import Foundation

@Observable
final class HomeViewModel {
	private(set) var categoryVM = CategoryViewModel()
	private(set) var productVM = ProductViewModel()
	
	var errorMessage: String? = nil
	var isLoading: Bool = false
	
	var topPicks: [Product] = []
	
	func load() async {
		// Load one time
		guard topPicks.isEmpty else { return }
		
		isLoading = true
		errorMessage = nil
		
		defer { isLoading = false }
		
		await categoryVM.loadCategories()
		await productVM.refresh()
		
		topPicks = Array(productVM.products.shuffled().prefix(8))
	}
}
