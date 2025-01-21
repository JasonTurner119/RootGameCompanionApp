//
//  SingleGameData.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts
import IdentifiedCollections

struct GameResultsView: View {
	
	@Binding var displayStyle: GameDetailModel.InfoDisplayStyle
	let playerRecords: IdentifiedArrayOf<Game.PlayerRecord>
	
	var body: some View {
		VStack(spacing: 20) {
			Picker("Data Display Style", selection: $displayStyle.animation(.snappy)) {
				Text("Chart")
					.tag(GameDetailModel.InfoDisplayStyle.chart)
				Text("Table")
					.tag(GameDetailModel.InfoDisplayStyle.table)
			}
			.pickerStyle(.segmented)
			
			switch displayStyle {
				case .chart:
					GameResultsChart(playerRecords: playerRecords)
				case .table:
					GameResultsTable(playerRecords: playerRecords)
			}
		}
	}
	
}

#Preview {
	@Previewable @State var displayStyle: GameDetailModel.InfoDisplayStyle = .chart
	ScrollView {
		GameResultsView(
			displayStyle: $displayStyle,
			playerRecords: Game.preview.playerRecords
		)
		.padding()
	}
}
