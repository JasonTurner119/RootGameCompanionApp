//
//  ColorComponents.swift
//  Root Companion
//
//  Created by Jason Turner on 1/8/25.
//

import SwiftUI

// From: https://www.hackingwithswift.com/forums/swiftui/resolved-colors-and-swiftdata/22483
struct ColorComponents: Codable, Hashable {
	let red: Float
	let green: Float
	let blue: Float

	var color: Color {
		Color(red: Double(red), green: Double(green), blue: Double(blue))
	}

	static func fromColor(_ color: Color) -> ColorComponents {
		let resolved = color.resolve(in: EnvironmentValues())
		return ColorComponents(
			red: resolved.red,
			green: resolved.green,
			blue: resolved.blue
		)
	}
}
