//
//  RecordCreationView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI

struct RecordCreationView: View {
	
	@Environment(Group.self) private var group: Group
	
	@Binding var gameRecords: [Game.PlayerRecord]
	
	@State private var player: Player?
	@State private var faction: Faction?
	
	@State private var score = 0.0
	
	@State private var playedDominance = false
	@State private var wonWithDominance = false
	
	@Environment(\.dismiss) private var dismiss: DismissAction
	
	private var submitDisabled: Bool {
		player == nil || faction == nil
	}
	
    var body: some View {
		
		Form {
			
			Section {
				LabeledContent("Player") {
					PlayerSelectionMenu(
						gamePlayers: gameRecords.map(\.player),
						selectedPlayer: $player
					)
				}
				
				LabeledContent("Faction") {
					FactionSelectionMenu(
						gameFactions: gameRecords.map(\.faction),
						selectedFaction: $faction
					)
				}
				
				Toggle(isOn: $playedDominance.animation()) {
					Text("Played Dominance")
				}
				
			}
			
			Section {
				
				if playedDominance {
					Toggle(isOn: $wonWithDominance) {
						Text("Won with Dominance")
					}
				} else {
					VStack {
						LabeledContent("Score") {
							let points = String(Int(score))
							Text(points)
						}
						Slider(
							value: $score,
							in: 0...30,
							step: 1
						)
					}
				}
			}
			
			Section {
				Button(action: submit) {
					HStack(alignment: .center) {
						Text("Submit")
							.bold()
							.frame(maxWidth: .infinity)
					}
				}
				.disabled(submitDisabled)
			}
			
		}
		.navigationTitle("Add Player")
		
    }
	
	private func submit() {
		guard let player, let faction else { return }
		let points = Int(score)
		let newRecord = Game.PlayerRecord(
			player: player,
			faction: faction,
			score: playedDominance ? .dominance : .points(points),
			didWin: playedDominance ? wonWithDominance : points == 30
		)
		gameRecords.append(newRecord)
		dismiss()
	}
	
}

#Preview {
	
	@Previewable @State var group: Group = .preview
	@Previewable @State var gameRecords: [Game.PlayerRecord] = []
	
	NavigationStack {
		RecordCreationView(
			gameRecords: $gameRecords
		)
	}
	.environment(group)
	
}
