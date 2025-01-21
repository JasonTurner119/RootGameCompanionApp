//
//  GroupListModel.swift
//  Root Companion
//
//  Created by Jason Turner on 1/20/25.
//

import Observation
import CasePaths

@MainActor
@Observable
final class GroupListModel {
	
	var destination: Destination?
	var groups: [Shared<Group>] = [Shared(.preview)]
	
	@CasePathable
	enum Destination {
		case groupDetail(GroupDetailModel)
	}
	
	func showDetail(for group: Shared<Group>) {
		let detailModel = GroupDetailModel(group: group)
		destination = .groupDetail(detailModel)
	}
	
}
