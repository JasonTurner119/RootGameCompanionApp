//
//  GameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts

struct GameView: View {
	
	let game: Game
	
    var body: some View {
		
		ScrollView {
			VStack(alignment: .leading) {
				
				if let date = game.date {
					DateView(date: date)
						.padding(.horizontal, 5)
				}
				
				GroupBox {
					SingleGameData(playerRecords: game.playerRecords)
				}
				
				if let location = game.location {
					GroupBox {
						HStack {
							Text("Location")
								.fontWeight(.medium)
							Spacer()
							Text(location.description)
						}
					}
				}
			}
			.padding(.horizontal)
		}
		.navigationTitle(game.name ?? "Game")
		
    }
	
}

#Preview {
	NavigationStack {
		GameView(game: .preview)
	}
}
