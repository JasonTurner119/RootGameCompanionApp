//
//  SingleGameGraph.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts
import IdentifiedCollections

struct GameResultsChart: View {
	
	let playerRecords: IdentifiedArrayOf<Game.PlayerRecord>
	
    var body: some View {
		Chart {
			ForEach(playerRecords) { playerRecord in
				let barHeight = playerRecord.score.points ?? 0
				BarMark(
					x: .value("Name", playerRecord.id.uuidString),
					y: .value("Points", barHeight)
				)
				.annotation {
					Text(playerRecord.score.description)
				}
				.cornerRadius(7.5)
				.foregroundStyle(playerRecord.faction.color)
			}
		}
		.chartXAxis {
			AxisMarks { value in
				let id = value.as(String.self).flatMap(UUID.init(uuidString: ))
				AxisValueLabel {
					if let id, let playerRecord = playerRecords[id: id] {
						let emoji = playerRecord.didWin ? " 🎉" : ""
						Text(playerRecord.player.name + emoji)
							.fontWeight(.medium)
							.foregroundStyle(Color.primary)
					}
				}
			}
		}
		.chartYScale(domain: 0...35)
		.frame(minHeight: 35 * 6)
    }
	
}

#Preview {
	GameResultsChart(playerRecords: Game.preview.playerRecords)
		.aspectRatio(1.5, contentMode: .fit)
		.padding()
}
