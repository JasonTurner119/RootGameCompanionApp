//
//  FactionSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI

struct FactionSelectionMenu: View {
	
	@Binding var groupFactions: [Faction]
	let gameFactions: [Faction]
	@Binding var selectedFaction: Faction?
	
	@State private var isPresentingNewFactionView = false
	
    var body: some View {
		
		Menu(selectedFaction?.name ?? "None") {
			
			Toggle(isOn: $selectedFaction[is: nil]) {
				Text("None Selected")
			}
			
			Divider()
			
			ForEach(groupFactions) { faction in
				Toggle(isOn: $selectedFaction[is: faction]) {
					Text(faction.name)
				}
				.disabled(
					gameFactions.contains(faction)
					&& selectedFaction?.id != faction.id
				)
			}
			
			Divider()
			
			Button(action: presentNewFactionView) {
				Text("New Faction")
				Image(systemName: "plus")
			}
			
		}
		.menuOrder(.fixed)
		.navigationDestination(isPresented: $isPresentingNewFactionView) {
			FactionCreationView()
		}
		
    }
	
	private func presentNewFactionView() {
		isPresentingNewFactionView = true
	}
	
}

extension Faction? {
	
	subscript (is faction: Faction?) -> Bool {
		get {
			return self?.id == faction?.id
		}
		set {
			if newValue {
				self = faction
			}
		}
	}
	
}

#Preview {
	
	@Previewable @State var groupFactions: [Faction] = .preview
	@Previewable @State var selectedFaction: Faction? = nil
	
	NavigationStack {
		FactionSelectionMenu(
			groupFactions: $groupFactions,
			gameFactions: [],
			selectedFaction: $selectedFaction
		)
	}
}
