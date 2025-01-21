//
//  FactionSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI
import SwiftUINavigation

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
