//
//  SingleGameTable.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import IdentifiedCollections

struct GameResultsTable: View {
	
	let playerRecords: IdentifiedArrayOf<Game.PlayerRecord>
	
    var body: some View {
		VStack {
			Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 10) {
				GridRow {
					Text("Player")
					Text("Faction")
					Text("Score")
					Text("")
				}
				.bold()
				Divider()
				ForEach(playerRecords, id: \.player) { playerRecord in
					GridRow {
						Text(playerRecord.player.name)
						Text(playerRecord.faction.name)
							.foregroundStyle(playerRecord.faction.color)
						Text(playerRecord.score.description)
							.gridColumnAlignment(.center)
						Text(playerRecord.didWin ? "🎉" : " ")
							.gridColumnAlignment(.center)
					}
					if playerRecord.player.id != playerRecords.last?.player.id {
						Divider()
					}
				}
			}
		}
    }
	
}

#Preview {
	GameResultsTable(playerRecords: Game.preview.playerRecords)
		.padding()
}
