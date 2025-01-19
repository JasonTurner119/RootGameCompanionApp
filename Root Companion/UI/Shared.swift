//
//  Untitled.swift
//  Root Companion
//
//  Created by Jason Turner on 1/18/25.
//

import Observation

@MainActor
@Observable
@dynamicMemberLookup
final class Shared<Value> {
	var value: Value
	init(_ value: Value) {
		self.value = value
	}
	subscript <T>(dynamicMember dynamicMember: KeyPath<Value, T>) -> T {
		get { return value[keyPath: dynamicMember] }
	}
	subscript <T>(dynamicMember dynamicMember: WritableKeyPath<Value, T>) -> T {
		get { return value[keyPath: dynamicMember] }
		set { value[keyPath: dynamicMember] = newValue }
	}
}

extension Shared: Identifiable where Value: Identifiable { }
