//
//  GameThumbnailView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct GameThumbnailView: View {
	
	let game: Game
	
    var body: some View {
		VStack(alignment: .leading) {
			if let date = game.date {
				dateView(for: date)
			}
			if let location = game.location {
				locationView(for: location)
			}
			PlayerRecordSummaryView(playerRecords: game.playerRecords)
		}
    }
	
	@ViewBuilder
	private func dateView(for date: Date) -> some View {
		let dateString = date.formatted(date: .abbreviated, time: .omitted)
		Text(dateString)
			.font(.headline)
	}
	
	@ViewBuilder
	private func locationView(for location: Location) -> some View {
		Text(location.description)
			.font(.subheadline)
	}
	
}

#Preview {
	NavigationStack {
		List([Game].preview) { game in
			NavigationLink(destination: GameView(game: game)) {
				GameThumbnailView(game: game)
			}
		}
	}
}
