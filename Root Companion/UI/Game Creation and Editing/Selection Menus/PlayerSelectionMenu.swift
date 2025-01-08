//
//  PlayerSelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 12/23/24.
//

import SwiftUI

struct PlayerSelectionMenu: View {
	
	@Environment(Group.self) private var group: Group
	let gamePlayers: [Player]
	@Binding var selectedPlayer: Player?
	@State var isPresentingNewPlayerView = false
	
    var body: some View {
		
		Menu(selectedPlayer?.name ?? "None") {
			
			Toggle(isOn: selectedPlayer(is: nil)) {
				Text("None Selected")
			}
			
			Divider()
			
			ForEach(group.players) { player in
				Toggle(isOn: selectedPlayer(is: player)) {
					Text(player.name)
				}
				.disabled(
					gamePlayers.contains(player)
					&& selectedPlayer?.id != player.id
				)
			}
			
			Divider()
			
			Button(action: presentNewPlayerView) {
				Text("New Player")
				Image(systemName: "plus")
			}
			
		}
		.menuOrder(.fixed)
		.navigationDestination(isPresented: $isPresentingNewPlayerView) {
			PlayerCreationView()
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
	
}

#Preview {
	
	@Previewable @State var group: Group = .preview
	@Previewable @State var selectedPlayer: Player? = nil
	
	NavigationStack {
		PlayerSelectionMenu(
			gamePlayers: [],
			selectedPlayer: $selectedPlayer
		)
	}
	.environment(group)
	
}
