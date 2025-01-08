//
//  ContentView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct ContentView: View {
	
	@State private var group: Group = .preview
	
    var body: some View {
		NavigationStack {
			GroupGameListView()
		}
		.environment(group)
    }
	
}

#Preview {
    ContentView()
}
