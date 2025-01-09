//
//  GameListView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct GroupGameListView: View {
	
	@Bindable var group: Group
	
	@State private var isPresentingNewGameView = false
	
    var body: some View {
		List {
			ForEach(group.games) { game in
				Section {
					NavigationLink(destination: GameView(game: game)) {
						GameThumbnailView(game: game)
					}
				}
			}
		}
		.listSectionSpacing(10)
		.navigationTitle("\(group.name)'s Games")
		.toolbar(content: {
			Button("Add") {
				isPresentingNewGameView = true
			}
		})
		.navigationDestination(isPresented: $isPresentingNewGameView) {
			NewGameView(group: group)
		}
    }
	
}

#Preview {
	
	let group: Group = .preview
	
	NavigationStack {
		GroupGameListView(group: group)
	}
	
}
