//
//  GroupDetailModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Foundation
import Observation
import CasePaths

@MainActor
@Observable
final class GroupDetailModel {
	
	var destination: Destination?
	var group: Shared<Group>
	
	init(destination: Destination? = nil, group: Shared<Group>) {
		self.destination = destination
		self.group = group
	}
	
	@CasePathable
	enum Destination {
		case newGame(NewGameModel)
		case gameDetail(GameDetailModel)
	}
	
	func showGameDetail(_ game: Game) {
		let gameDetailModel = GameDetailModel(
			game: game,
			infoDisplayStyle: .chart
		)
		destination = .gameDetail(gameDetailModel)
	}
	
	func addGameButtonPressed() {
		let game = Game(id: UUID(), playerRecords: [])
		let newGameModel = NewGameModel(group: self.group, game: game)
		destination = .newGame(newGameModel)
	}
	
}
