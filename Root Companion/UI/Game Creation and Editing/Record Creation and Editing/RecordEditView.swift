//
//  RecordEditView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI

struct RecordEditView: View {
	
	@Binding var groupLocations: [InPersonLocation]
	@Binding var groupPlayers: [Player]
	@Binding var groupFactions: [Faction]
	
	@Binding var record: Game.PlayerRecord
	
    var body: some View {
        
		NotYetImplementedView()
		
    }
	
}

#Preview {
	
	@Previewable @State var groupLocations: [InPersonLocation] = .preview
	@Previewable @State var groupPlayers: [Player] = .preview
	@Previewable @State var groupFactions: [Faction] = .preview

	@Previewable @State var record = Game.preview.playerRecords.first!
	
	RecordEditView(
		groupLocations: $groupLocations,
		groupPlayers: $groupPlayers,
		groupFactions: $groupFactions,
		record: $record
	)
	
}
