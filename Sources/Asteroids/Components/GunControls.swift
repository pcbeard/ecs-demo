//
//  GunControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS

final class GunControls<ControlCode : Hashable>: ComponentInitializable {
    var triggers: Set<ControlCode>

    init(triggers: Set<ControlCode>) {
        self.triggers = triggers
    }

    required init() {
        self.triggers = []
    }
}
