//
//  GroupListView.swift
//  Root Companion
//
//  Created by Jason Turner on 1/8/25.
//

import SwiftUI
import SwiftData

struct GroupListView: View {
	
	@Query var groups: [Group]
	@Environment(\.modelContext) var modelContext
	
    var body: some View {
        
		List(groups) { group in
			NavigationLink(value: group) {
				Text(group.name)
			}
		}
		.navigationTitle("Groups")
		.navigationDestination(for: Group.self) { group in
			GroupGameListView(group: group)
		}
		.onAppear {
			modelContext.insert(Group.preview)
		}
		
    }
	
}

#Preview {
	
	NavigationStack {
		GroupListView()
	}
	.modelContainer(for: Group.self)
	
}
