//
//  Faction.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation
import SwiftUICore

struct Faction: Identifiable, Hashable, Codable {
	
	var id: UUID
	var name: String
	private var colorComponents: ColorComponents
	var color: Color {
		get { colorComponents.color }
		set { colorComponents = .fromColor(newValue) }
	}
	
	init(id: UUID, name: String, color: Color) {
		self.id = id
		self.name = name
		self.colorComponents = .fromColor(color)
	}
	
}

extension Faction {
	static let marquiseDeCat = Faction(
		id: UUID(uuidString: "a5603cc9-ca71-480e-935b-0ddb1b734404")!,
		name: "Marquise de Cat",
		color: .orange
	)
	static let eyrieDynasties = Faction(
		id: UUID(uuidString: "6a1d0478-9325-4ab8-9640-2d64c8990bc1")!,
		name: "Eyrie Dynasties",
		color: .blue
	)
	static let woodlandAlliance = Faction(
		id: UUID(uuidString: "ed6ca159-e85e-44c4-b99d-5c1ed01ad8e4")!,
		name: "Woodland Alliance",
		color: .green
	)
	static let vagabond = Faction(
		id: UUID(uuidString: "eacdcc71-9df2-443c-b5b2-c633b3d6fe3d")!,
		name: "Vagabond",
		color: .gray
	)
}

extension [Faction] {
	static let preview: [Faction] = [
		.marquiseDeCat,
		.eyrieDynasties,
		.woodlandAlliance,
		.vagabond,
	]
}
