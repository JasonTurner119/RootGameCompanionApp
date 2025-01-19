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
class GroupListModel: ObservableObject {
	
	@Published var destination: Destination?
	@Published var groups: IdentifiedArrayOf<ObservedGroup> = [
		ObservedGroup(group: .preview)
	]
	
	private var cancellables: Set<AnyCancellable> = []
	
	@CasePathable
	enum Destination {
		case groupDetail(GroupDetailModel)
	}
	
	func showDetail(for group: ObservedGroup) {
		let detailModel = GroupDetailModel(group: group)
		destination = .groupDetail(detailModel)
	}
	
}

struct GroupListView: View {
	
	@StateObject private var model = GroupListModel()
	
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
