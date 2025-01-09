//
//  Location.swift
//  Root Companion
//
//  Created by Jason Turner on 12/29/24.
//

import Foundation

enum Location: Hashable, Codable {
	case online
	case inPerson(InPersonLocation)
}

struct InPersonLocation: Identifiable, Hashable, Codable {
	var id: UUID
	var name: String
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
	static let idaho = InPersonLocation(
		id: UUID(uuidString: "a92e4865-4e6c-4aad-834b-bae64fae43c0")!,
		name: "Idaho"
	)
	static let california = InPersonLocation(
		id: UUID(uuidString: "dcf5e5d5-7d96-4251-8a34-efbabf093b76")!,
		name: "California"
	)
	static let alaska = InPersonLocation(
		id: UUID(uuidString: "548545b2-c3f1-4c6c-8540-09ef56af2b21")!,
		name: "Alaska"
	)
}

extension [InPersonLocation] {
	static let preview: Self = [
		.idaho,
		.california,
		.alaska,
	]
}
