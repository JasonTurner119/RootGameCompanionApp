//
//  GroupListView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/8/25.
//

import SwiftUI
import SwiftUINavigation
import IdentifiedCollections
import Combine

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

struct GroupListView: View {
	
	@Bindable private var model = GroupListModel()
	
    var body: some View {
		List(self.model.groups) { group in
			Button(action: { self.model.showDetail(for: group) }) {
				VStack {
					Text(group.name)
					Text("\(group.games.count) Games")
				}
			}
		}
		.navigationTitle("Groups")
		.navigationDestination(item: self.$model.destination.groupDetail) { detailModel in
			GroupDetailView(model: detailModel)
		}
    }
	
}

#Preview {
	NavigationStack {
		GroupListView()
	}
}
