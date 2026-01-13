//
//  TopPicksGrid.swift
//  Market
//
//  Created by Evan Best on 2026-01-12.
//

import SwiftUI

struct TopPicksGrid: View {
	let products: [Product]
	let onProductTapped: (Product, Namespace.ID) -> Void
	
	@Namespace private var animation

	private let columns: [GridItem] = [
		GridItem(.flexible(), spacing: 12),
		GridItem(.flexible(), spacing: 12)
	]

	var body: some View {
		LazyVGrid(columns: columns, spacing: 16) {
			ForEach(products, id: \.id) { product in
				Button {
					onProductTapped(product, animation)
				} label: {
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
				}
				.buttonStyle(.plain)
			}
		}
		.padding()
	}
}

#Preview {
	NavigationStack {
		ScrollView {
			TopPicksGrid(
				products: [
					Product(
						id: 1,
						title: "Sample Product",
						slug: "sample-product",
						price: 99.99,
						description: "This is a sample product used for preview purposes.",
						category: Category(id: 1, name: "Electronics", image: "", slug: "electronics"),
						images: ["https://picsum.photos/id/1/420/420"]
					),
					Product(
						id: 2,
						title: "Another Product",
						slug: "another-product",
						price: 59.99,
						description: "Another sample for grid preview.",
						category: Category(id: 2, name: "Books", image: "", slug: "books"),
						images: ["https://picsum.photos/id/3/420/420"]
					),
					Product(
						id: 3,
						title: "Grocery Bundle",
						slug: "grocery-bundle",
						price: 29.49,
						description: "A set of fresh groceries.",
						category: Category(id: 3, name: "Groceries", image: "", slug: "groceries"),
						images: ["https://picsum.photos/id/4/420/420"]
					),
					Product(
						id: 4,
						title: "Cool Backpack",
						slug: "cool-backpack",
						price: 89.95,
						description: "Perfect for students and travelers.",
						category: Category(id: 4, name: "Accessories", image: "", slug: "accessories"),
						images: ["https://picsum.photos/id/5/420/420"]
					),
					Product(
						id: 5,
						title: "Modern Desk Lamp",
						slug: "modern-desk-lamp",
						price: 34.99,
						description: "Stylish lighting for your workspace.",
						category: Category(id: 5, name: "Home", image: "", slug: "home"),
						images: ["https://picsum.photos/id/6/420/420"]
					),
					Product(
						id: 6,
						title: "Running Shoes",
						slug: "running-shoes",
						price: 120.00,
						description: "Comfortable shoes for all your runs.",
						category: Category(id: 6, name: "Shoes", image: "", slug: "shoes"),
						images: ["https://picsum.photos/id/7/420/420"]
					)
				],
				onProductTapped: { _, _ in }
			)
		}
	}
}
