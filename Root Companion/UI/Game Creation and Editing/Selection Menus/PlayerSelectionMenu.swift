//
//  PlayerSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI

struct PlayerSelectionMenu: View {
	
	@ObservedObject var group: ObservedGroup
	let gamePlayers: [Player]
	@Binding var selectedPlayer: Player?
	@State var isPresentingNewPlayerView = false
	
    var body: some View {
		
		let title = selectedPlayer?.name ?? "None"
		
		SelectionMenu(title, selection: $selectedPlayer) {
			
			Text("None Selected")
				.tag(nil as Player?)
			
			Divider()
			
			ForEach(group.players) { player in
				Text(player.name)
					.tag(player)
					.containerValue(\.selectionEnabled, enable(player: player))
			}
			
			Divider()
			
			Button(action: presentNewPlayerView) {
				Text("New Player")
				Image(systemName: "plus")
			}
			
		}
		.navigationDestination(isPresented: $isPresentingNewPlayerView) {
			NotYetImplementedView()
		}
		
    }
	
	private func selectedPlayer(is player: Player?) -> Binding<Bool> {
		Binding(
			get: {
				selectedPlayer?.id == player?.id
			},
			set: { newValue in
				assert(newValue, "Binding must not be set to false.")
				selectedPlayer = player
			}
		)
	}
	
	private func presentNewPlayerView() {
		isPresentingNewPlayerView = true
	}
	
	private func enable(player: Player) -> Bool {
		!gamePlayers.contains(player) || selectedPlayer?.id == player.id
	}
	
}

#Preview {
	
	@Previewable @State var selectedPlayer: Player? = nil
	
	NavigationStack {
		PlayerSelectionMenu(
			group: ObservedGroup(group: .preview),
			gamePlayers: [],
			selectedPlayer: $selectedPlayer
		)
	}
	
}
