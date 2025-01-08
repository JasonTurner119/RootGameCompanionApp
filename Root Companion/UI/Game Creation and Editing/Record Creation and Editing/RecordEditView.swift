//
//  RecordEditView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/3/25.
//

import SwiftUI

struct RecordEditView: View {
	
	@Binding var record: Game.PlayerRecord
	
    var body: some View {
        
		NotYetImplementedView()
		
    }
	
}

#Preview {
	
	@Previewable @State var record = Game.preview.playerRecords.first!
	
	RecordEditView(
		record: $record
	)
	
}
