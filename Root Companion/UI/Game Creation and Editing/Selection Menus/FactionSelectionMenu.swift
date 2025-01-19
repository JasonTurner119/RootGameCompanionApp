//
//  FactionSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI
import SwiftUINavigation

class FactionSelectionMenuModel: ObservableObject {
	
	@Published var destination: Destination?
	@ObservedObject var group: ObservedGroup
	@Binding var selectedFaction: Faction?
	let disabledFactions: [Faction]
	
	init(
		destination: Destination? = nil,
		group: ObservedGroup,
		selectedFaction: Binding<Faction?>,
		disabledFactions: [Faction]
	) {
		self.destination = destination
		self.group = group
		self._selectedFaction = selectedFaction
		self.disabledFactions = disabledFactions
	}
	
	@CasePathable
	enum Destination {
		case newFaction
	}
	
	func newFactionButtonPressed() {
		self.destination = .newFaction
	}
	
	func isEnabled(faction: Faction) -> Bool {
		!self.disabledFactions.contains(faction)
	}
	
}

struct FactionSelectionMenu: View {
	
	@ObservedObject var model: FactionSelectionMenuModel
	
	@State private var isPresentingNewFactionView = false
	
    var body: some View {
		let title = self.model.selectedFaction?.name ?? "None"
		SelectionMenu(title, selection: self.$model.selectedFaction) {
			Text("None Selected")
				.tag(nil as Faction?)
			Divider()
			ForEach(self.model.group.factions) { faction in
				Text(faction.name)
					.tag(faction)
					.containerValue(
						\.selectionEnabled,
						 self.model.isEnabled(faction: faction)
					)
			}
			Divider()
			Button(action: { self.model.newFactionButtonPressed() }) {
				Text("New Faction")
				Image(systemName: "plus")
			}
		}
		.navigationDestination(isPresented: $isPresentingNewFactionView) {
			NotYetImplementedView()
		}
    }
	
}

#Preview {
	
	@Previewable @State var selectedFaction: Faction? = nil
	@Previewable @State var group: Group = .preview
	
	NavigationStack {
		FactionSelectionMenu(
			model: FactionSelectionMenuModel(
				group: ObservedGroup(group: .preview),
				selectedFaction: $selectedFaction,
				disabledFactions: []
			)
		)
	}
	
}
