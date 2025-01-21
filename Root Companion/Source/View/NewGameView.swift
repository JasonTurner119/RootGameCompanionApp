//
//  NewGameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import SwiftUINavigation

struct NewGameView: View {
	
	@Bindable var model: NewGameModel
	@Environment(\.dismiss) private var dismiss
	
    var body: some View {
		Form {
			Section("General") {
				generalSection
			}
			Section("Players") {
				playersSection
			}
			createGameButton
		}
		.navigationTitle("New Game")
		.onChange(of: self.model.dismissed) { self.dismiss() }
		.navigationDestination(item: self.$model.destination.addPlayer) { addPlayerModel in
			RecordCreationView(model: addPlayerModel)
		}
    }
	
	@ViewBuilder
	private var generalSection: some View {
		DatePicker(
			"Date",
			selection: self.$model.game.date,
			displayedComponents: .date
		)
		LabeledContent("Location") {
			LocationSelectionMenu(
				group: self.model.group,
				selectedLocation: self.$model.game.location
			)
		}
	}
	
	@ViewBuilder
	private var playersSection: some View {
		ForEach(self.$model.game.playerRecords, editActions: .delete) { $record in
			HStack {
				Text(record.player.name)
				if record.didWin {
					Text("🎉")
				}
				Spacer()
				Text(record.faction.name)
					.foregroundStyle(record.faction.color)
			}
		}
		Button(action: { self.model.addPlayerButtonPressed() }) {
			Text("Add Player")
		}
	}
	
	@ViewBuilder
	private var createGameButton: some View {
		Section {
			Button(action: { self.model.createGame() } ) {
				Text("Create Game")
			}
			.disabled(self.model.game.validity.is(\.invalid))
		} footer: {
			if case .invalid(let reason) = self.model.game.validity {
				Text(reason)
			}
		}
	}
	
}

#Preview {
	NavigationStack {
		NewGameView(
			model: NewGameModel(
				group: Shared(.preview),
				game: .preview
			)
		)
	}
}
