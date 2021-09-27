//
//  MotionControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS
import AsteroidsGameLibrary

final class MotionControls<InputType: Hashable>: ComponentInitializable {
    var left: Set<InputType>
    var right: Set<InputType>
    var accelerate: Set<InputType>
    var decelerate: Set<InputType>

    var accelerationRate: Double
    var rotationRate: Double

    init(left: Set<InputType>, right: Set<InputType>, accelerate: Set<InputType>, decelerate: Set<InputType>, accelerationRate: Double, rotationRate: Double) {
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
