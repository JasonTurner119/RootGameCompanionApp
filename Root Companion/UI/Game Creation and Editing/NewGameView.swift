//
//  NewGameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import SwiftUINavigation

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
