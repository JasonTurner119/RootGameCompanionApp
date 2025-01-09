//
//  GameRecordsEditView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI

struct GameRecordsEditView: View {
	
	@Bindable var group: Group
	
	@Binding var records: [Game.PlayerRecord]
	
	@State var isShowingAddPlayerForm = false
	
    var body: some View {
		
		ForEach($records, editActions: .delete) { record in
			NavigationLink(
				destination: {
					RecordEditView(
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
				group: group,
				gameRecords: $records
			)
		}
		
    }
	
	private func showAddPlayerForm() {
		isShowingAddPlayerForm = true
	}
	
}

#Preview {
	
	@Previewable @State var records: [Game.PlayerRecord] = []
	let group: Group = .preview
	
	NavigationStack {
		Form {
			GameRecordsEditView(
				group: group,
				records: $records
			)
		}
	}
	
}
