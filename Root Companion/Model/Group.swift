//
//  Group.swift
//  Root Companion
//
//  Created by Jason Turner on 12/28/24.
//

import Foundation

struct Group {
	var id: UUID
	var name: String
	var games: [Game]
	var locations: [InPersonLocation]
	var players: [Player]
	var factions: [Faction]
}

extension Group {
	static let preview: Group = Group(
		id: UUID(),
		name: "Root 66",
		games: .preview,
		locations: .preview,
		players: .preview,
		factions: .preview
	)
}
