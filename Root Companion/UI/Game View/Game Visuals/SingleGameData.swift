//
//  SingleGameData.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts

struct SingleGameData: View {
	
	@State private var selectedOption: SelectionOption = .chart
	let playerRecords: [Game.PlayerRecord]
	
	var body: some View {
		
		VStack(spacing: 20) {
			
			Picker("Data Display Style", selection: $selectedOption.animation(.snappy)) {
				Text("Chart")
					.tag(SelectionOption.chart)
				Text("Table")
					.tag(SelectionOption.table)
			}
			.pickerStyle(.segmented)
			
			switch selectedOption {
				case .chart:
					SingleGameChart(playerRecords: playerRecords)
				case .table:
					SingleGameTable(playerRecords: playerRecords)
			}
			
		}
		
	}
	
	private enum SelectionOption {
		case chart
		case table
	}
	
}

#Preview {
	ScrollView {
		SingleGameData(playerRecords: Game.preview.playerRecords)
			.padding()
	}
}
