//
//  LocationSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/29/24.
//

import SwiftUI

struct LocationSelectionMenu: View {
	
	@ObservedObject var group: ObservedGroup
	@Binding var selectedLocation: Location?
	
	@State private var isPresentingNewLocationView = false
	
    var body: some View {
        
		let title = selectedLocation?.description ?? "None"
		
		SelectionMenu(title, selection: $selectedLocation) {
			
			Text("None")
				.tag(nil as Location?)
			
			Divider()
			
			Text("Online")
				.tag(Location.online)
			
			Divider()
			
			ForEach(group.locations) { location in
				Text(location.name)
					.tag(Location.inPerson(location))
			}
			
			Divider()
			
			Button(action: createNewLocation) {
				Label("New", systemImage: "plus")
			}
			
		}
		.navigationDestination(isPresented: $isPresentingNewLocationView) {
			NotYetImplementedView()
		}
		
    }
	
	private func createNewLocation() {
		isPresentingNewLocationView = true
	}
	
}

#Preview {
	@Previewable @State var selectedLocation: Location? = nil
	
	NavigationStack {
		LocationSelectionMenu(
			group: ObservedGroup(group: .preview),
			selectedLocation: $selectedLocation
		)
	}
}
