//
//  Score.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation

enum Score: Hashable, Codable {
	case points(Int)
	case dominance
}

extension Score {
	var isDominance: Bool {
		switch self {
		case .points: false
		case .dominance: true
		}
	}
	var isPoints: Bool {
		switch self {
		case .points: true
		case .dominance: false
		}
	}
	var points: Int? {
		switch self {
		case .points(let points): points
		case .dominance: nil
		}
	}
}

extension Score {
	var description: String {
		switch self {
		case .points(let points):
			return "\(points)"
		case .dominance:
			return ""
		}
	}
}
