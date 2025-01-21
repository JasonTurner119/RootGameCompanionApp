//
//  GroupListView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/8/25.
//

import SwiftUI
import SwiftUINavigation

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
