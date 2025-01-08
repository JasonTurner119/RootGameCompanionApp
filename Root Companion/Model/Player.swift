//
//  Player.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation

struct Player: Identifiable, Hashable {
	let id = UUID()
	let name: String
}

extension Player {
	static let jason = Player(name: "Jason")
	static let grace = Player(name: "Grace")
	static let emily = Player(name: "Emily")
	static let ben = Player(name: "Ben")
}

extension [Player] {
	static let preview: [Player] = [.jason, .grace, .ben, .emily]
}
