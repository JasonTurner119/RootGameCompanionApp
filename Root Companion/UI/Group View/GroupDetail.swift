//
//  GameListView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import SwiftUINavigation
import Combine

@MainActor
class GroupDetailModel: ObservableObject {
	
	@Published var destination: Destination?
	@ObservedObject var group: ObservedGroup
	
	init(destination: Destination? = nil, group: ObservedGroup) {
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

struct GroupDetailView: View {
	
	@ObservedObject var model: GroupDetailModel
	
    var body: some View {
		List {
			ForEach(self.model.group.games) { game in
				Section {
					Button(action: { self.model.showGameDetail(game) }) {
						GameThumbnailView(game: game)
					}
					.tint(Color.primary)
				}
			}
		}
		.listSectionSpacing(10)
		.navigationTitle("\(self.model.group.name)'s Games")
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button("Add") {
					self.model.addGameButtonPressed()
				}
			}
		}
		.navigationDestination(item: self.$model.destination.gameDetail) { gameDetailModel in
			GameDetailView(model: gameDetailModel)
		}
		.navigationDestination(item: self.$model.destination.newGame) { newGameModel in
			NewGameView(model: newGameModel)
		}
    }
	
}

#Preview {
	NavigationStack {
		GroupDetailView(
			model: GroupDetailModel(group: ObservedGroup(group: .preview))
		)
	}
}
