//  ProductImage.swift
//  Market
//
//  Extracted by assistant

import SwiftUI

struct ProductImage: View {
    let product: Product
    let animation: Namespace.ID

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let urlString = product.images.first, let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Color(.systemGray6)
                                .overlay(ProgressView().controlSize(.small))
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        case .failure:
                            Color(.systemGray6)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundStyle(.secondary)
                                )
                        @unknown default:
                            Color(.systemGray6)
                        }
                    }
                } else {
                    Color(.systemGray6)
                        .overlay(
                            Image(systemName: "photo")
                                .foregroundStyle(.secondary)
                        )
                }
            }
        }
        .aspectRatio(3/4, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .matchedGeometryEffect(id: product.id, in: animation)
    }
}
