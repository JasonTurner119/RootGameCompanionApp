//
//  NotYetImplementedView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/28/24.
//

import SwiftUI

struct NotYetImplementedView: View {
    var body: some View {
		ScrollView {
			GroupBox {
				Text("Not yet implemented")
					.frame(maxWidth: .infinity)
			}
			.padding()
		}
    }
}

#Preview {
	NotYetImplementedView()
}
