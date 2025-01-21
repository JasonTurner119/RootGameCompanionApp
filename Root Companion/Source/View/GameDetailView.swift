//
//  GameView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI
import Charts

struct GameDetailView: View {
	
	@Bindable var model: GameDetailModel
	
    var body: some View {
		
		ScrollView {
			VStack(alignment: .leading) {
				
				let date = self.model.game.date
				Text(date.formatted(date: .long, time: .omitted))
					.font(.subheadline)
				
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
