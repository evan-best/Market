//
//  ProductGrid.swift
//  Market
//
//  Created by Evan Best on 2026-01-12.
//

import SwiftUI

struct ProductGrid: View {
	let products: [Product]
	let animation: Namespace.ID

	private let columns = [GridItem(.flexible()), GridItem(.flexible())]

	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(products, id: \.id) { product in
					NavigationLink(value: product) {
						VStack(alignment: .leading, spacing: 4) {
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
		}
	}
}

#Preview {
    struct PreviewHost: View {
        @Namespace var animation
        
        var products: [Product] = [
            Product(
                id: 1,
                title: "Sample Product",
                description: "This is a sample product used for preview purposes.",
                category: "Electronics",
                price: 99.99,
                discountPercentage: 0.0,
                rating: 4.5,
                stock: 10,
                tags: ["sample", "electronics"],
                brand: "SampleBrand",
				sku: "SKU12345",
                dimensions: Dimensions(width: 10, height: 5, depth: 2),
                warrantyInformation: "1 year limited warranty",
                shippingInformation: "Ships within 3-5 business days",
                reviews: [Review(rating: 5, comment: "Great product!", date: Date(), reviewerName: "John Doe", reviewerEmail: "john@example.com")],
                returnPolicy: "30-day return policy",
                minimumOrderQuantity: 1,
                thumbnail: "https://picsum.photos/id/1/420/420",
                images: ["https://picsum.photos/id/1/420/420"]
            ),
            Product(
                id: 2,
                title: "Another Product",
                description: "Another sample for grid preview.",
                category: "Books",
                price: 59.99,
                discountPercentage: 5.0,
                rating: 4.0,
                stock: 5,
                tags: ["book", "reading"],
                brand: "BookBrand",
				sku: "SKU67890",
                dimensions: Dimensions(width: 8, height: 11, depth: 1),
                warrantyInformation: "No warranty",
                shippingInformation: "Ships within 1-2 business days",
                reviews: [],
                returnPolicy: "No returns",
                minimumOrderQuantity: 1,
                thumbnail: "https://picsum.photos/id/3/420/420",
                images: ["https://picsum.photos/id/3/420/420"]
            )
        ]
        var body: some View {
            ProductGrid(products: products, animation: animation)
        }
    }
    return PreviewHost()
}
