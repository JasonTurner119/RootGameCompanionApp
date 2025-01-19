//
//  GameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts

final class GameDetailModel: ObservableObject {
	
	let game: Game
	@Published var infoDisplayStyle: InfoDisplayStyle
	
	init(game: Game, infoDisplayStyle: InfoDisplayStyle) {
		self.game = game
		self.infoDisplayStyle = infoDisplayStyle
	}
	
	enum InfoDisplayStyle {
		case chart
		case table
	}
	
}

struct GameDetailView: View {
	
	@ObservedObject var model: GameDetailModel
	
    var body: some View {
		
		ScrollView {
			VStack(alignment: .leading) {
				
				DateView(date: self.model.game.date)
					.padding(.horizontal, 5)
				
				GroupBox {
					GameResultsView(
						displayStyle: self.$model.infoDisplayStyle,
						playerRecords: self.model.game.playerRecords
					)
				}
				
				if let location = self.model.game.location {
					GroupBox {
						HStack {
							Text("Location")
								.fontWeight(.medium)
							Spacer()
							Text("\(location)")
						}
					}
				}
			}
			.padding(.horizontal)
		}
		.navigationTitle(self.model.game.name ?? "Game")
		
    }
	
}

#Preview {
	NavigationStack {
		GameDetailView(
			model: GameDetailModel(
				game: .preview,
				infoDisplayStyle: .chart
			)
		)
	}
}
