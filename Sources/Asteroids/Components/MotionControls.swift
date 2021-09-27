//
//  MotionControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS
import AsteroidsGameLibrary

final class MotionControls<ControlCode : Hashable>: ComponentInitializable {
    var left: Set<ControlCode>
    var right: Set<ControlCode>
    var accelerate: Set<ControlCode>
    var decelerate: Set<ControlCode>

    var accelerationRate: Double
    var rotationRate: Double

    init(left: Set<ControlCode>, right: Set<ControlCode>, accelerate: Set<ControlCode>, decelerate: Set<ControlCode>, accelerationRate: Double, rotationRate: Double) {
        self.left = left
        self.right = right
        self.accelerate = accelerate
        self.decelerate = decelerate
        self.accelerationRate = accelerationRate
        self.rotationRate = rotationRate
    }

    required init() {
        left = []
        right = []
        accelerate = []
        decelerate = []
        accelerationRate = 0
        rotationRate = 0
    }
}
