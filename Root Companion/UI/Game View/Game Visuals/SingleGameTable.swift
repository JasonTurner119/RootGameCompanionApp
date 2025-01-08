//
//  SingleGameTable.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

extension Score {
	var description: String {
		switch self {
		case .points(let points):
			return "\(points)"
		case .dominance:
			return ""
		}
	}
}

struct SingleGameTable: View {
	
	let playerRecords: [Game.PlayerRecord]
	
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
							.foregroundStyle(
								Color.primary.mix(with: playerRecord.faction.color, by: 0.8)
							)
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
	SingleGameTable(playerRecords: Game.preview.playerRecords)
		.padding()
}
