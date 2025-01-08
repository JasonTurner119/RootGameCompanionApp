//
//  LocationCreationView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/29/24.
//

import SwiftUI

struct LocationCreationView: View {
	
	@Binding var groupLocations: [InPersonLocation]
	
    var body: some View {
		NotYetImplementedView()
			.navigationTitle("Create New Location")
    }
}

#Preview {
	
	@Previewable @State var groupLocations: [InPersonLocation] = []
	
	LocationCreationView(
		groupLocations: $groupLocations
	)
	
}
