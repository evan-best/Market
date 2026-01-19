//
//  ProductDetailView.swift
//  Market
//
//  Created by Evan Best on 2026-01-12.
//

import SwiftUI

struct ProductDetailView: View {
	let product: Product

	@State private var vm = ProductDetailViewModel()
	@State private var currentImageIndex: Int = 0

	@Namespace private var animation

	private var imageURLs: [URL] {
		product.images.compactMap { URL(string: $0) }
	}

	var body: some View {
		ZStack {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {

					// Hero Image Carousel - 75% of screen height
					ZStack(alignment: .bottomTrailing) {
						TabView(selection: $currentImageIndex) {
							ForEach(Array(imageURLs.enumerated()), id: \.offset) { index, imageURL in
								GeometryReader { geometry in
									CachedAsyncImage(url: imageURL) { phase in
										switch phase {
										case .success(let image):
											image
												.resizable()
												.interpolation(.high)
												.aspectRatio(contentMode: .fill)
												.frame(
													width: geometry.size.width,
													height: UIScreen.main.bounds.height * 0.75
												)
												.clipped()
												.drawingGroup()
										case .failure:
											placeholderView
												.frame(
													width: geometry.size.width,
													height: UIScreen.main.bounds.height * 0.75
												)
										case .empty:
											ZStack {
												Rectangle().fill(Color(.systemGray6))
												ProgressView()
											}
											.frame(
												width: geometry.size.width,
												height: UIScreen.main.bounds.height * 0.75
											)
										@unknown default:
											placeholderView
												.frame(
													width: geometry.size.width,
													height: UIScreen.main.bounds.height * 0.75
												)
										}
									}
								}
								.tag(index)
							}
						}
						.tabViewStyle(.page)
						.frame(height: UIScreen.main.bounds.height * 0.75)

						if imageURLs.count > 1 {
							Text("\(currentImageIndex + 1)/\(imageURLs.count)")
								.font(.system(size: 14, weight: .semibold))
								.foregroundStyle(.white)
								.padding(.horizontal, 12)
								.padding(.vertical, 8)
								.glassEffect(.clear)
								.padding(16)
						}
					}

					// Content section
					VStack(alignment: .leading, spacing: 16) {
						Text(product.title)
							.font(.title2)
							.fontWeight(.bold)

						HStack(spacing: 8) {
							Text(product.price, format: .currency(code: "CAD"))
								.font(.headline)

							Text("•")
								.foregroundStyle(.secondary)

							Text(product.category)
								.foregroundStyle(.secondary)
						}

						if !product.description.isEmpty {
							Text(product.description)
								.foregroundStyle(.secondary)
								.padding(.top, 6)
						}
						
						Text("Related products")
							.font(.title3)
							.bold()
						// Related products
						if vm.isLoading {
							ProgressView()
								.padding(.top, 10)
						} else if !vm.relatedProducts.isEmpty {
							ProductGrid(
								products: vm.relatedProducts,
								animation: animation
							)
							.padding(.top, 8)
						}
					}
					.padding()
					.background(Color(.systemBackground))
				}
			}
			.scrollEdgeEffectStyle(.soft, for: .all)
			.navigationBarTitleDisplayMode(.inline)
			.ignoresSafeArea(edges: .top)
		}
		.navigationTitle("Product")
		.navigationBarTitleDisplayMode(.inline)
		.task(id: product.id) {
			await vm.loadFromCategory(for: product.category)
		}
	}

	private var placeholderView: some View {
		ZStack {
			Rectangle()
				.fill(Color(.systemGray6))

			VStack(spacing: 8) {
				Image(systemName: "camera")
					.font(.system(size: 42, weight: .semibold))
					.foregroundStyle(Color(.systemGray2))
				Text("No photos")
					.font(.system(size: 18, weight: .medium))
					.foregroundStyle(Color(.systemGray2))
			}
		}
	}
}



#Preview {
    ProductDetailView(product: Product(
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
        reviews: [],
        returnPolicy: "30-day return policy",
        minimumOrderQuantity: 1,
        thumbnail: "https://picsum.photos/id/1/420/420",
        images: ["https://picsum.photos/id/1/420/420","https://picsum.photos/id/2/420/420","https://picsum.photos/id/3/420/420","https://picsum.photos/id/4/420/420","https://picsum.photos/id/5/420/420"]
    ))
}
