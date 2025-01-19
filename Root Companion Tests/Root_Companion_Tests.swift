//
//  Root_Companion_Tests.swift
//  Root Companion Tests
//
//  Created by Jason Turner on 1/18/25.
//

import Testing
@testable import Root_Companion

@MainActor
struct Root_Companion_Tests {

    @Test func addNewGame() async throws {
		
		let model = GroupListModel()
		
		#expect(model.destination == nil)
		#expect(model.groups.count == 1)
		
		let groupId = model.groups.first!.id
		model.showDetail(for: model.groups.first!)
		
		#expect(model.destination.is(\.groupDetail))
		guard case .groupDetail(let detailModel) = model.destination else { return }
		#expect(detailModel.destination == nil)
		#expect(detailModel.group.id == groupId)
		#expect(detailModel.group.games.count == 3)
		
		detailModel.addGameButtonPressed()
		
		#expect(detailModel.destination.is(\.newGame))
		guard case .newGame(let newGameModel) = detailModel.destination else { return }
		#expect(newGameModel.destination == nil)
		#expect(newGameModel.game.playerRecords.count == 0)
		
		newGameModel.addPlayerButtonPressed()
		
		#expect(newGameModel.destination.is(\.addPlayer))
		guard case .addPlayer(let addPlayerModel) = newGameModel.destination else { return }
		#expect(addPlayerModel.group.id == groupId)
		#expect(!addPlayerModel.canSumbit)
		
		addPlayerModel.player = .jason
		addPlayerModel.faction.value = .woodlandAlliance
		addPlayerModel.score = .points(30)
		
		#expect(addPlayerModel.canSumbit)
		
		addPlayerModel.submit()
		
		#expect(addPlayerModel.dissmissed)
		// #expect(newGameModel.destination == nil)
		#expect(newGameModel.game.playerRecords.count == 1)
		#expect(newGameModel.game.validity == .valid)
		
		newGameModel.createGame()
		
		#expect(newGameModel.dismissed)
		// #expect(detailModel.destination == nil)
		
		detailModel.destination = nil
		
		#expect(detailModel.group.games.count == 4)
		
    }

}
