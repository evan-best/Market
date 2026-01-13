//
//  HomeView.swift
//  Market
//
//  Created by Evan Best on 2026-01-09.
//

import SwiftUI

struct HomeView: View {
	@State private var categoryVM = CategoryViewModel()
	@State private var productVM = ProductViewModel()
	@State private var searchText: String = ""
	@State private var path: [Product] = []
	@State private var topPicks: [Product] = []

	@Namespace private var animation

	var body: some View {
		ScrollView {
			VStack(alignment: .leading, spacing: 6) {

				Text("Categories")
					.font(.title2)
					.bold()
					.padding(.horizontal)

				// Categories
				ScrollView(.horizontal, showsIndicators: false) {
					HStack(spacing: 12) {
						ForEach(categoryVM.categories) { category in
							NavigationLink(destination: ProductsView(category: category)) {
								CategoryButton(category: category)
							}
							.buttonStyle(.plain)
						}
					}
					.padding(.horizontal)
				}

				Spacer(minLength: 16)
				
				// Top Picks
				if !topPicks.isEmpty {
					HStack {
						Text("Top Picks")
							.font(.title2)
							.bold()
						Spacer()
					}
					.padding(.horizontal)
					LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
						ForEach(topPicks, id: \.id) { product in
							NavigationLink(value: product) {
								VStack(alignment: .leading, spacing: 8) {
									ProductImage(product: product, animation: animation)
									Text(product.title)
										.font(.subheadline)
										.fontWeight(.semibold)
										.lineLimit(1)
									Text(product.price, format: .currency(code: "CAD"))
										.font(.system(size: 14))
										.fontWeight(.semibold)
										.lineLimit(1)
								}
								.matchedTransitionSource(id: product.id, in: animation)
							}
							.buttonStyle(.plain)
						}
					}
					.padding(.horizontal)
				}

				Spacer(minLength: 16)
			}
			.padding(.top, 8)
		}
		.scrollClipDisabled(true)
		.task {
			await categoryVM.loadCategories()
			await productVM.refresh()

			if topPicks.isEmpty {
				topPicks = Array(productVM.products.shuffled().prefix(6))
			}
		}

		.searchable(text: $searchText, placement: .navigationBarDrawer)
		.toolbar {
			ToolbarItem(placement: .principal) {
				Image("market-logo")
					.resizable()
					.scaledToFit()
					.frame(width: 86, height: 86)
			}
		}
		.navigationBarTitleDisplayMode(.inline)
		.navigationDestination(for: Product.self) { product in
			ProductDetailView(product: product)
				.navigationTransition(.zoom(sourceID: product.id, in: animation))
		}
	}
}

#Preview {
	NavigationStack {
		HomeView()
	}
}

