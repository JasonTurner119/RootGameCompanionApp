//
//  NewGameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct NewGameView: View {
	
	@Environment(Group.self) var group: Group
		
	@State private var date: Date = .now
	@State private var location: Location? = nil
	@State private var records: [Game.PlayerRecord] = []
	
	@Environment(\.dismiss) private var dismiss: DismissAction
	
	private var gameHasWinner: Bool {
		records.map(\.didWin).contains(true)
	}
	
	private var game: Game {
		Game(
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
						selectedLocation: $location
					)
				}
				
			}
			
			Section("Players") {
				GameRecordsEditView(
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
	
	@Previewable @State var group: Group = .preview
	
	NavigationStack {
		NewGameView()
	}
	.environment(group)
	
}
