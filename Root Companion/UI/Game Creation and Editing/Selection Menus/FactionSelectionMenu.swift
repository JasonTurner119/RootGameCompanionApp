//
//  FactionSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI
import SwiftUINavigation

@MainActor
@Observable
final class FactionSelectionMenuModel {
	
	var destination: Destination?
	let group: Shared<Group>
	var selectedFaction: Shared<Faction?>
	let disabledFactions: [Faction]
	
	init(
		destination: Destination? = nil,
		group: Shared<Group>,
		selectedFaction: Shared<Faction?>,
		disabledFactions: [Faction]
	) {
		self.destination = destination
		self.group = group
		self.selectedFaction = selectedFaction
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
	
	@Bindable var model: FactionSelectionMenuModel
	
	@State private var isPresentingNewFactionView = false
	
    var body: some View {
		let title = self.model.selectedFaction.value?.name ?? "None"
		SelectionMenu(title, selection: self.$model.selectedFaction.value) {
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
				group: Shared(.preview),
				selectedFaction: Shared(.eyrieDynasties),
				disabledFactions: []
			)
		)
	}
	
}
