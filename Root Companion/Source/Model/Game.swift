//
//  Game.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import Foundation
import CasePaths
import IdentifiedCollections

struct Game: Identifiable, Codable, Hashable {
	var id: UUID
	var name: String?
	var location: Location?
	var date: Date = Date()
	var playerRecords: IdentifiedArrayOf<PlayerRecord>
}

extension Game {
	struct PlayerRecord: Identifiable, Codable, Hashable {
		var player: Player
		var faction: Faction
		var score: Score
		var didWin: Bool
		var id: UUID { player.id }
	}
}

extension Game {
	@CasePathable
	enum Validity: Equatable {
		case valid
		case invalid(message: String)
	}
	var validity: Validity {
		
		if playerRecords.isEmpty {
			return .invalid(message: "There must be at least one player in the game.")
		}
		
		let winners = playerRecords
			.filter(\.didWin)
		
		if winners.isEmpty {
			return .invalid(message: "There must be at least one winner in the game.")
		}
		
		let pointsWinners = winners
			.filter(\.score.isPoints)
			.count
		
		if winners.contains(where: { $0.score.isPoints && $0.score != .points(30) }) {
			return .invalid(message: "A player cannot win by points unless they have 30.")
		}
		
		let nonCoalitionDominanceWinners = winners
			.filter(\.score.isDominance)
			.filter { $0.faction != .vagabond }
			.count
		
		let tooManyWinnersReason = "Multiple players cannot win together unless the Vagabond forms a coalition."
		
		switch pointsWinners {
		case 0:
			// Dominance victory (maybe w/ coalitions)
			switch nonCoalitionDominanceWinners {
			case 0:
				return .invalid(message: """
				A Vagabond played dominance, so they must have formed a coalition.
				The Vagabond won, so the faction they formed a coalition with must have too.
				""")
			case 1:
				return .valid
			default:
				return .invalid(message: tooManyWinnersReason)
			}
		case 1:
			// Points victory (maybe w/ coalitions)
			guard nonCoalitionDominanceWinners == 0 else {
				return .invalid(message: tooManyWinnersReason)
			}
			return .valid
		default:
			return .invalid(message: tooManyWinnersReason)
		}
		
	}
}

extension Game {
	static var preview: Game {
		IdentifiedArrayOf<Game>.preview.first!
	}
}

extension IdentifiedArrayOf<Game> {
	static var preview: IdentifiedArrayOf<Game> {
		[
			Game(
				id: UUID(uuidString: "8074a1c2-a24b-492f-8edc-616641883b4b")!,
				name: "Game 1",
				location: .online,
				date: Date(),
				playerRecords: [
					Game.PlayerRecord(
						player: .jason,
						faction: .marquiseDeCat,
						score: .points(30),
						didWin: true
					),
					Game.PlayerRecord(
						player: .grace,
						faction: .eyrieDynasties,
						score: .points(21),
						didWin: false
					),
					Game.PlayerRecord(
						player: .ben,
						faction: .woodlandAlliance,
						score: .points(10),
						didWin: false
					),
					Game.PlayerRecord(
						player: .emily,
						faction: .vagabond,
						score: .points(25),
						didWin: false
					),
				]
			),
			Game(
				id: UUID(uuidString: "5e9f3add-c615-4c9e-bad7-2c40032e4816")!,
				name: "Game 2",
				location: .online,
				date: Date(),
				playerRecords: [
					Game.PlayerRecord(
						player: .jason,
						faction: .eyrieDynasties,
						score: .points(12),
						didWin: false
					),
					Game.PlayerRecord(
						player: .grace,
						faction: .woodlandAlliance,
						score: .points(30),
						didWin: true
					),
					Game.PlayerRecord(
						player: .ben,
						faction: .marquiseDeCat,
						score: .points(15),
						didWin: false
					),
					Game.PlayerRecord(
						player: .emily,
						faction: .vagabond,
						score: .dominance,
						didWin: true
					),
				]
			),
			Game(
				id: UUID(uuidString: "cdacb536-3527-4163-a30c-ae857572a53f")!,
				name: "Game 3",
				location: .online,
				date: Date(),
				playerRecords: [
					Game.PlayerRecord(
						player: .jason,
						faction: .vagabond,
						score: .points(10),
						didWin: false
					),
					Game.PlayerRecord(
						player: .grace,
						faction: .eyrieDynasties,
						score: .points(21),
						didWin: false
					),
					Game.PlayerRecord(
						player: .ben,
						faction: .marquiseDeCat,
						score: .points(29),
						didWin: false
					),
					Game.PlayerRecord(
						player: .emily,
						faction: .woodlandAlliance,
						score: .points(30),
						didWin: true
					),
				]
			),
		]
	}
}

