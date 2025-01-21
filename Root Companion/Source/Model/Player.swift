//
//  Player.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation

struct Player: Identifiable, Hashable, Codable {
	var id: UUID
	var name: String
}

extension Player {
	static let jason = Player(
		id: UUID(uuidString: "33a725a0-ff7e-4f75-9972-015b06616676")!,
		name: "Jason"
	)
	static let grace = Player(
		id: UUID(uuidString: "b731c3bb-9166-4d9b-ba85-3c0236a51c63")!,
		name: "Grace"
	)
	static let emily = Player(
		id: UUID(uuidString: "0d254baf-b5fa-4df3-b05e-0a46d75ecd13")!,
		name: "Emily"
	)
	static let ben = Player(
		id: UUID(uuidString: "03dc585d-8399-46ec-a602-3a14e0563473")!,
		name: "Ben"
	)
}

extension [Player] {
	static let preview: [Player] = [.jason, .grace, .ben, .emily]
}
