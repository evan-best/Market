//
//  APIClient.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

/// API client for making requests and decoding
final class APIClient {
	static let shared = APIClient(
		baseURL: URL(string: "https://dummyjson.com/products")!
	)
	private let baseURL: URL
	private let session: URLSession
	private let decoder: JSONDecoder
	
	private init(baseURL: URL, session: URLSession = .shared, decoder: JSONDecoder = .init()) {
		self.baseURL = baseURL
		self.session = session
		decoder.dateDecodingStrategy = .iso8601
		self.decoder = decoder
	}
	
	/// Makes URL from a given endpoint
	private func makeURL(from endpoint: Endpoint) throws -> URL {
		var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path), resolvingAgainstBaseURL: true)
		
		components?.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems
		
		guard let url = components?.url else {
			throw APIError.invalidURL
		}
		
		return url
	}
	
	/// Makes a GET request for a given endpoint
	func get<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
		// Build the final URL from baseURL + endpoint
		let url = try makeURL(from: endpoint)

		// Create the request
		var request = URLRequest(url: url)
		request.httpMethod = "GET"

		let data: Data
		let response: URLResponse

		// Perform the network request
		do {
			(data, response) = try await session.data(for: request)
		} catch {
			throw APIError.other(error.localizedDescription)
		}

		// Ensure we received an HTTP response
		guard let http = response as? HTTPURLResponse else {
			throw APIError.nonHTTPResponse
		}

		// Validate HTTP status code
		guard (200...299).contains(http.statusCode) else {
			let body = String(data: data, encoding: .utf8) ?? ""
			throw APIError.httpStatus(http.statusCode, body: body)
		}

		// Decode response
		do {
			if let jsonString = String(data: data, encoding: .utf8) {
				print("API Response:", jsonString)
			}
			return try decoder.decode(T.self, from: data)
		} catch {
			print("Decoding error:", error)
			throw APIError.decodingFailed
		}
	}


}
