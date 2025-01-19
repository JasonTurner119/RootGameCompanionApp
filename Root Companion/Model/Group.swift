//
//  Group.swift
//  Root Companion
//
//  Created by Jason Turner on 12/28/24.
//

import Foundation
import IdentifiedCollections

struct Group: Identifiable, Codable, Hashable {
	
	var id: UUID
	var name: String
	var games: IdentifiedArrayOf<Game>
	var locations: [InPersonLocation]
	var players: [Player]
	var factions: [Faction]
	
}

extension Group {
	static let preview: Group = Group(
		id: UUID(uuidString: "f8cc2a5f-5098-47ec-84af-70e3c221988f")!,
		name: "Root 66",
		games: .preview,
		locations: .preview,
		players: .preview,
		factions: .preview
	)
}
