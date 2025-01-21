//
//  NewGameModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Observation
import CasePaths

@MainActor
@Observable
final class NewGameModel {
	
	var destination: Destination? {
		didSet { self.bind() }
	}
	
	var group: Shared<Group>
	var game: Game
	var dismissed: Bool = false
	
	init(destination: Destination? = nil, group: Shared<Group>, game: Game) {
		self.destination = destination
		self.group = group
		self.game = game
		bind()
	}
	
	@CasePathable
	enum Destination {
		case addPlayer(RecordCreationModel)
	}
	
	func createGame() {
		guard self.game.validity == .valid else { return }
		self.group.games.append(self.game)
		self.dismissed = true
	}
	
	func addPlayerButtonPressed() {
		let recordCreationModel = RecordCreationModel(
			group: self.group,
			disabledPlayers: game.playerRecords.map(\.player),
			disabledFactions: game.playerRecords.map(\.faction)
		)
		self.destination = .addPlayer(recordCreationModel)
	}
	
	private func bind() {
		switch self.destination {
		case .addPlayer(let recordCreationModel):
			recordCreationModel.addRecord = { [weak self] in
				self?.game.playerRecords.append($0)
			}
		case .none:
			break
		}
	}
	
}
