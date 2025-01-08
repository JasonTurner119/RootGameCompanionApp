//
//  Location.swift
//  Root Companion
//
//  Created by Jason Turner on 12/29/24.
//

import Foundation

enum Location: Hashable {
	case online
	case inPerson(InPersonLocation)
}

struct InPersonLocation: Identifiable, Hashable {
	let id = UUID()
	let name: String
}

extension Location {
	var description: String {
		switch self {
		case .online:
			"Online"
		case .inPerson(let inPersonLocation):
			inPersonLocation.name
		}
	}
}
extension InPersonLocation {
	static let idaho = InPersonLocation(name: "Idaho")
	static let california = InPersonLocation(name: "California")
	static let alaska = InPersonLocation(name: "Alaska")
}

extension [InPersonLocation] {
	static let preview: Self = [
		.idaho,
		.california,
		.alaska,
	]
}
