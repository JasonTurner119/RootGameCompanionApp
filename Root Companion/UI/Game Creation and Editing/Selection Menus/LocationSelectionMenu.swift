//
//  LocationSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/29/24.
//

import SwiftUI

struct LocationSelectionMenu: View {
	
	@Binding var groupLocations: [InPersonLocation]
	@Binding var selectedLocation: Location?
	
	@State private var isPresentingNewLocationView = false
	
    var body: some View {
        
		Menu(selectedLocation?.description ?? "None") {
			
			Toggle(
				"Online",
				isOn: $selectedLocation[is: .online]
			)
			.tag(Location.online)
			
			Divider()
			
			ForEach(groupLocations) { location in
				Toggle(
					location.name,
					isOn: $selectedLocation[
						is: .inPerson(location)
					]
				)
			}
			
			Divider()
			
			Toggle(
				"None",
				isOn: $selectedLocation[is: nil]
			)
			
			Divider()
			
			Button(action: createNewLocation) {
				Label("New", systemImage: "plus")
			}
			
		}
		.menuOrder(.fixed)
		.navigationDestination(isPresented: $isPresentingNewLocationView) {
			LocationCreationView(
				groupLocations: $groupLocations
			)
		}
		
    }
	
	private func createNewLocation() {
		isPresentingNewLocationView = true
	}
	
}
				   
extension Location? {
	subscript (is location: Location?) -> Bool {
		get {
			switch (self, location) {
			case (nil, nil):
				true
			case (.online, .online):
				true
			case (.inPerson(let l), .inPerson(let r)):
				l.id == r.id
			default:
				false
			}
		}
		set {
			if newValue {
				self = location
			}
		}
	}
}

#Preview {
	
	@Previewable @State var groupLocations: [InPersonLocation] = .preview
	@Previewable @State var selectedLocation: Location? = nil
	
	NavigationStack {
		LocationSelectionMenu(
			groupLocations: $groupLocations,
			selectedLocation: $selectedLocation
		)
	}
	
}
