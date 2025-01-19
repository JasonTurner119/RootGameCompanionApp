//
//  PlayerRecordSummaryView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/28/24.
//

import SwiftUI
import IdentifiedCollections

struct PlayerRecordSummaryView: View {
	
	let playerRecords: IdentifiedArrayOf<Game.PlayerRecord>
	
    var body: some View {
		
		let sorted = playerRecords.sorted(by: { playerSorter(first: $0, second: $1) })
		
		HStack(spacing: 0) {
			ForEach(sorted) { playerRecord in
				view(for: playerRecord)
				if playerRecord.id != sorted.last?.id {
					seperatorView
				}
			}
		}
		
    }
	
	@ViewBuilder
	private func view(for playerRecord: Game.PlayerRecord) -> some View {
		
		Text(playerRecord.player.name)
			.foregroundStyle(playerRecord.faction.color)
		
		if playerRecord.didWin {
			Text("🎉")
				.font(.caption)
				.padding(.leading, 5)
		}
		
	}
	
	@ViewBuilder
	private var seperatorView: some View {
		Text("・")
	}
	
	private func playerSorter(first: Game.PlayerRecord, second: Game.PlayerRecord) -> Bool {
		switch (first.didWin, second.didWin) {
		case (true, false):
			true
		case (false, true):
			false
		default:
			switch (first.score, second.score) {
			case (.points(let firstPoints), .points(let secondPoints)):
				firstPoints > secondPoints || (firstPoints == secondPoints && first.player.id < second.player.id)
			case (.points, .dominance):
				true
			case (.dominance, .points):
				false
			case (.dominance, .dominance):
				first.player.id < second.player.id
			}
		}
	}
	
}

#Preview {
	PlayerRecordSummaryView(playerRecords: Game.preview.playerRecords)
}
