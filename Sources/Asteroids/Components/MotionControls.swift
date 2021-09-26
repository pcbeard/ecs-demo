//
//  MotionControls.swift
//  FirebladeECSDemo
//
//  Created by Igor Kravchenko on 18.11.2020.
//

import FirebladeECS
import AsteroidsGameLibrary
import SDL

final class MotionControls: ComponentInitializable {
    var left: Set<SDL_KeyCode>
    var right: Set<SDL_KeyCode>
    var accelerate: Set<SDL_KeyCode>
    var decelerate: Set<SDL_KeyCode>

    var accelerationRate: Double
    var rotationRate: Double

    init(left: Set<SDL_KeyCode>, right: Set<SDL_KeyCode>, accelerate: Set<SDL_KeyCode>, decelerate: Set<SDL_KeyCode>, accelerationRate: Double, rotationRate: Double) {
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
