//
//  DateView.swift
//  Root Companion
//
//  Created by Jason Turner on 12/20/24.
//

import SwiftUI

struct DateView: View {
	
	let date: Date
	
    var body: some View {
		Text(date.formatted(date: .long, time: .omitted))
			.font(.subheadline)
    }
}

#Preview {
	DateView(date: .now)
}
