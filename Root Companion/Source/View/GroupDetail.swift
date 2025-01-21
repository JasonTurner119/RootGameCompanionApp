//
//  GameListView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import SwiftUINavigation
import Combine

struct GroupDetailView: View {
	
	@Bindable var model: GroupDetailModel
	
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
			model: GroupDetailModel(group: Shared(.preview))
		)
	}
}
