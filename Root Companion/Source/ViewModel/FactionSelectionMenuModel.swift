//
//  FactionSelectionMenuModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Observation
import CasePaths

@MainActor
@Observable
final class FactionSelectionMenuModel {
	
	var destination: Destination?
	let group: Shared<Group>
	var selectedFaction: Shared<Faction?>
	let disabledFactions: [Faction]
	
	init(
		destination: Destination? = nil,
		group: Shared<Group>,
		selectedFaction: Shared<Faction?>,
		disabledFactions: [Faction]
	) {
		self.destination = destination
		self.group = group
		self.selectedFaction = selectedFaction
		self.disabledFactions = disabledFactions
	}
	
	@CasePathable
	enum Destination {
		case newFaction
	}
	
	func newFactionButtonPressed() {
		self.destination = .newFaction
	}
	
	func isEnabled(faction: Faction) -> Bool {
		!self.disabledFactions.contains(faction)
	}
	
}
