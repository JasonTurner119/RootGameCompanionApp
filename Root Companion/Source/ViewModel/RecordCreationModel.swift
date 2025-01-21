//
//  RecordCreationModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Observation
import XCTestDynamicOverlay

@MainActor
@Observable
final class RecordCreationModel {
	
	let group: Shared<Group>
	let disabledPlayers: [Player]
	let disabledFactions: [Faction]
	var player: Player? = nil
	var faction: Shared<Faction?> = Shared(nil)
	var score: Score
	var won: Bool = false
	var dissmissed: Bool = false
	
	var addRecord: (Game.PlayerRecord) -> Void = unimplemented("RecordCreationModel.addRecord")
	
	init(
		group: Shared<Group>,
		disabledPlayers: [Player],
		disabledFactions: [Faction],
		player: Player? = nil,
		faction: Shared<Faction?> = Shared(nil),
		score: Score = .points(0),
		won: Bool = false
	) {
		self.group = group
		self.disabledPlayers = disabledPlayers
		self.disabledFactions = disabledFactions
		self.player = player
		self.faction = faction
		self.score = score
		self.won = won
	}
	
	func submit() {
		guard let player, let faction = faction.value else { return }
		let newRecord = Game.PlayerRecord(
			player: player,
			faction: faction,
			score: score,
			didWin: score == .points(30) || (score.isDominance && won)
		)
		self.addRecord(newRecord)
		self.dissmissed = true
	}
	
	var canSumbit: Bool {
		player != nil && faction.value != nil
	}
	
}
