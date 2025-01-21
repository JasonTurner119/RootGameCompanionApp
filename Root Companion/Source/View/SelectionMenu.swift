//
//  SelectionMenu.swift
//  Root Companion
//
//  Created by Jason Turner on 1/18/25.
//

import SwiftUI

struct SelectionMenu<Selection: Hashable, Content: View>: View {
	
	private let title: String
	@Binding private var selection: Selection?
	private let content: Content
	
	init(
		_ title: String,
		selection: Binding<Selection?>,
		@ViewBuilder content: () -> Content
	) {
		self.title = title
		self._selection = selection
		self.content = content()
	}
	
    var body: some View {
		Menu(title) {
			ForEach(subviews: content) { subview in
				if let tag: Selection? = subview.containerValues.wrappedTag() {
					Toggle(isOn: $selection[equals: tag]) {
						subview
					}
					.disabled(!subview.containerValues.selectionEnabled)
				} else {
					subview
				}
			}
		}
		.menuOrder(.fixed)
    }
	
}

extension ContainerValues {
	@Entry var selectionEnabled: Bool = true
}

private extension ContainerValues {
	func wrappedTag<T: Hashable>(for _: T.Type = T.self) -> T? {
		tag(for: T?.self) ?? tag(for: T.self)
	}
}

private extension Optional where Wrapped: Hashable {
	subscript (equals value: Self) -> Bool {
		get { return self == value }
		set { self = newValue ? value : nil }
	}
}

#Preview {
	@Previewable @State var selection: Faction? = nil
	
	SelectionMenu("Faction Menu", selection: $selection) {
		Text("None").tag(nil as Faction?)
		Divider()
		ForEach(Group.preview.factions) { faction in
			Text(faction.name)
				.containerValue(\.selectionEnabled, faction.name != "Vagabond")
				.tag(faction)
		}
		Divider()
		Button("Add") {
			
		}
	}
}
