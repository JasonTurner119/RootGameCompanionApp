//
//  Faction.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation
import SwiftUICore

struct Faction: Identifiable, Hashable {
	let id = UUID()
	let name: String
	let color: Color
}

extension Faction {
	static let marquiseDeCat = Faction(name: "Marquise de Cat", color: .orange)
	static let eyrieDynasties = Faction(name: "Eyrie Dynasties", color: .blue)
	static let woodlandAlliance = Faction(name: "Woodland Alliance", color: .green)
	static let vagabond = Faction(name: "Vagabond", color: .gray)
}

extension [Faction] {
	static let preview: [Faction] = [
		.marquiseDeCat,
		.eyrieDynasties,
		.woodlandAlliance,
		.vagabond,
	]
}
