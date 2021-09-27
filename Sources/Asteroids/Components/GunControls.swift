//
//  GunControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS

final class GunControls<InputType: Hashable>: ComponentInitializable {
    var trigger: Set<InputType>

    init(trigger: Set<InputType>) {
        self.trigger = trigger
    }

    required init() {
        self.trigger = []
    }
}
