//
//  APIError.swift
//  Market
//
//  Created by Evan Best on 2026-01-08.
//

import Foundation

enum APIError: Error, LocalizedError {
	case invalidURL
	case nonHTTPResponse
	case httpStatus(Int, body: String)
	case decodingFailed
	case noDataReturned
	case other(String)
	
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .nonHTTPResponse:
			return "Response was not an HTTP response"
		case .httpStatus(let code, let body):
			return "HTTP error with status code \(code): \(body)"
		case .decodingFailed:
			return "Failed to decode JSON"
		case .noDataReturned:
			return "No data was returned from the server"
		case .other(let message):
			return message
		}
	}
}
