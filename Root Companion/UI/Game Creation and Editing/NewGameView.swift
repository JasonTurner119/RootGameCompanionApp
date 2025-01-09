//
//  NewGameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct NewGameView: View {
	
	@Bindable var group: Group
	
	private let gameId = UUID()
	@State private var date: Date = .now
	@State private var location: Location? = nil
	@State private var records: [Game.PlayerRecord] = []
	
	@Environment(\.dismiss) private var dismiss: DismissAction
	
	private var gameHasWinner: Bool {
		records.map(\.didWin).contains(true)
	}
	
	private var game: Game {
		Game(
			id: gameId,
			name: nil,
			location: location,
			date: date,
			playerRecords: records
		)
	}
	
	private var createGameIsDisabled: Bool {
		game.validity != .valid
	}
	
	private var createGameFooterString: String {
		switch game.validity {
		case .valid:
			return "Add game to group's history."
		case .invalid(let reason):
			return reason
		}
	}
	
    var body: some View {
        
		Form {
			
			Section("General") {
				
				DatePicker(
					"Date",
					selection: $date,
					displayedComponents: .date
				)
				
				LabeledContent("Location") {
					LocationSelectionMenu(
						group: group,
						selectedLocation: $location
					)
				}
				
			}
			
			Section("Players") {
				GameRecordsEditView(
					group: group,
					records: $records
				)
			}
			
			Section(
				content: {
					Button(action: createGame) {
						Text("Create Game")
					}
					.disabled(createGameIsDisabled)
				},
				footer: {
					Text(createGameFooterString)
				}
			)
			
		}
		.navigationTitle("New Game")
		
    }
	
	private func createGame() {
		guard game.validity == .valid else {
			assertionFailure("Game must be valid to be added.")
			return
		}
		group.games.append(game)
		dismiss()
	}
	
}

#Preview {
	
	let group: Group = .preview
	
	NavigationStack {
		NewGameView(group: group)
	}
	
}
