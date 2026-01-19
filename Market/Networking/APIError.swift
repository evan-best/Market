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
		case .httpStatus(let code, _):
			switch code {
			case 401, 403:
				return "You don’t have permission to do that."
			case 404:
				return "Not found."
			case 429:
				return "Too many requests. Try again in a moment."
			case 500...599:
				return "The server is having trouble right now. Try again."
			default:
				return "Something went wrong. Please try again."
			}
		case .decodingFailed:
			return "Failed to decode JSON"
		case .noDataReturned:
			return "No data was returned from the server"
		case .other(let message):
			return message
		}
	}
}
