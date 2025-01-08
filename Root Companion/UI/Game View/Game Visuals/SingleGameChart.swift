//
//  SingleGameGraph.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts

struct SingleGameChart: View {
	
	@State private var message = "None"

	let playerRecords: [Game.PlayerRecord]
	
    var body: some View {
		Chart {
			ForEach(playerRecords) { playerRecord in
				let barHeight = switch playerRecord.score {
					case .points(let points): points
					case .dominance: 0
				}
				BarMark(
					x: .value("Name", playerRecord.id.uuidString),
					y: .value("Points", barHeight)
				)
				.annotation {
					let text = switch playerRecord.score {
						case .points(let points): "\(points)"
						case .dominance: ""
					}
					Text(text)
				}
				.cornerRadius(7.5)
				.foregroundStyle(playerRecord.faction.color)
			}
		}
		.chartXAxis {
			AxisMarks { value in
				AxisValueLabel {
					if
						let uuidString = value.as(String.self),
						let playerRecord = playerRecords.first(where: { $0.id.uuidString == uuidString })
					{
						let emoji = playerRecord.didWin ? " 🎉" : ""
						Text(playerRecord.player.name + emoji)
							.fontWeight(.bold)
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
	SingleGameChart(playerRecords: Game.preview.playerRecords)
		.aspectRatio(1.5, contentMode: .fit)
		.padding()
}
