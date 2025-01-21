//
//  GameDetailModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Observation

@MainActor
@Observable
final class GameDetailModel {
	
	let game: Game
	var infoDisplayStyle: InfoDisplayStyle
	
	init(game: Game, infoDisplayStyle: InfoDisplayStyle) {
		self.game = game
		self.infoDisplayStyle = infoDisplayStyle
	}
	
	enum InfoDisplayStyle {
		case chart
		case table
	}
	
}
