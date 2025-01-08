//
//  GameRecordsEditView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI

struct GameRecordsEditView: View {
	
	@Binding var groupLocations: [InPersonLocation]
	@Binding var groupPlayers: [Player]
	@Binding var groupFactions: [Faction]
	
	@Binding var records: [Game.PlayerRecord]
	
	@State var isShowingAddPlayerForm = false
	
    var body: some View {
		
		ForEach($records, editActions: .delete) { record in
			NavigationLink(
				destination: {
					RecordEditView(
						groupLocations: $groupLocations,
						groupPlayers: $groupPlayers,
						groupFactions: $groupFactions,
						record: record
					)
				},
				label: {
					let record = record.wrappedValue
					HStack {
						Text(record.player.name)
						if record.didWin {
							Text("🎉")
						}
						Spacer()
						Text(record.faction.name)
							.foregroundStyle(record.faction.color)
					}
				}
			)
		}
		
		Button(action: showAddPlayerForm) {
			Text("Add Player")
		}
		.navigationDestination(isPresented: $isShowingAddPlayerForm) {
			RecordCreationView(
				groupLocations: $groupLocations,
				groupPlayers: $groupPlayers,
				groupFactions: $groupFactions,
				gameRecords: $records
			)
		}
		
    }
	
	private func showAddPlayerForm() {
		isShowingAddPlayerForm = true
	}
	
}

#Preview {
	
	@Previewable @State var groupLocations: [InPersonLocation] = .preview
	@Previewable @State var groupPlayers: [Player] = .preview
	@Previewable @State var groupFactions: [Faction] = .preview
	
	@Previewable @State var records: [Game.PlayerRecord] = []
	
	NavigationStack {
		Form {
			GameRecordsEditView(
				groupLocations: $groupLocations,
				groupPlayers: $groupPlayers,
				groupFactions: $groupFactions,
				records: $records
			)
		}
	}
	
}
