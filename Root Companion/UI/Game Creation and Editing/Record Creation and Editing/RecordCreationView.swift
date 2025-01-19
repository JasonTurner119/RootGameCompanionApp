//
//  RecordCreationView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI
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

struct RecordCreationView: View {
	
	@Bindable var model: RecordCreationModel
	@Environment(\.dismiss) private var dismiss
	
	@State private var sliderValue: Double = 0.0
	
	private var playedDominance: Binding<Bool> {
		Binding(
			get: { self.model.score.isDominance },
			set: { self.model.score = $0 ? .dominance : .points(0) }
		)
	}
	
    var body: some View {
		Form {
			Section {
				LabeledContent("Player") {
					PlayerSelectionMenu(
						group: self.model.group,
						gamePlayers: self.model.disabledPlayers,
						selectedPlayer: self.$model.player
					)
				}
				LabeledContent("Faction") {
					FactionSelectionMenu(
						model: FactionSelectionMenuModel(
							group: self.model.group,
							selectedFaction: self.model.faction,
							disabledFactions: self.model.disabledFactions
						)
					)
				}
				Toggle(isOn: playedDominance) {
					Text("Played Dominance")
				}
			}
			Section {
				switch self.model.score {
				case .dominance:
					Toggle(isOn: self.$model.won) {
						Text("Won with Dominance")
					}
				case .points(let points):
					VStack {
						LabeledContent("Score") {
							Text("\(points)")
						}
						Slider(
							value: $sliderValue,
							in: 0...30,
							step: 1
						)
						.onChange(of: sliderValue) { self.model.score = .points(Int(sliderValue)) }
					}
				}
			}
			Section {
				Button(action: { self.model.submit() }) {
					HStack(alignment: .center) {
						Text("Submit")
							.bold()
							.frame(maxWidth: .infinity)
					}
				}
				.disabled(!self.model.canSumbit)
			}
			
		}
		.navigationTitle("Add Player")
		.onChange(of: self.model.dissmissed) { self.dismiss() }
		
    }
	
}

#Preview {
	
	NavigationStack {
		RecordCreationView(
			model: RecordCreationModel(
				group: Shared(.preview),
				disabledPlayers: [.emily],
				disabledFactions: [.eyrieDynasties]
			)
		)
	}
	
}
