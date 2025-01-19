//
//  Untitled.swift
//  Root Companion
//
//  Created by Jason Turner on 1/18/25.
//

import Combine

@dynamicMemberLookup
class ObservedGroup: ObservableObject, Identifiable {
	@Published var group: Group
	init(group: Group) {
		self.group = group
	}
	subscript <T>(dynamicMember dynamicMember: KeyPath<Group, T>) -> T {
		get { return group[keyPath: dynamicMember] }
	}
	subscript <T>(dynamicMember dynamicMember: WritableKeyPath<Group, T>) -> T {
		get { return group[keyPath: dynamicMember] }
		set { group[keyPath: dynamicMember] = newValue }
	}
}
